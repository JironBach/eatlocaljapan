# == Schema Information
#
# Table name: listings
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  review_count              :integer          default(0)
#  ave_total                 :float            default(0.0)
#  ave_accuracy              :float            default(0.0)
#  ave_communication         :float            default(0.0)
#  ave_cleanliness           :float            default(0.0)
#  ave_location              :float            default(0.0)
#  ave_check_in              :float            default(0.0)
#  ave_cost_performance      :float            default(0.0)
#  open                      :boolean          default(FALSE)
#  zipcode                   :string
#  location                  :string           default("")
#  longitude                 :decimal(9, 6)    default(0.0)
#  latitude                  :decimal(9, 6)    default(0.0)
#  delivery_flg              :boolean          default(FALSE)
#  price                     :integer          default(0)
#  description               :text             default("")
#  title                     :string           default("")
#  capacity                  :integer          default(0)
#  direction                 :text             default("")
#  cover_image               :string           default("")
#  cover_image_caption       :string           default("")
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  smoking_id                :integer
#  business_hours_remarks    :text
#  shop_description          :text
#  shop_description_en       :text
#  price_low                 :integer
#  price_high                :integer
#  tel                       :string
#  url                       :string
#  review_url                :string
#  recommended               :text
#  recommended_en            :text
#  visit_benefits            :string
#  visit_benefits_another    :string
#  title_en                  :string
#  price_low_dinner          :integer
#  price_high_dinner         :integer
#  english_message_id        :integer
#  info_admin_id             :integer
#  link_tabelog              :string
#  link_yelp                 :string
#  link_tripadvisor          :string
#  description_en            :text
#  location_en               :string
#  visit_benefits_en         :string
#  visit_benefits_another_en :string
#  reservation_frame         :integer
#  unit                      :integer
#  from                      :integer
#  to                        :integer
#  reservation_time_unit     :integer
#
# Indexes
#
#  index_listings_on_capacity   (capacity)
#  index_listings_on_latitude   (latitude)
#  index_listings_on_location   (location)
#  index_listings_on_longitude  (longitude)
#  index_listings_on_price      (price)
#  index_listings_on_title      (title)
#  index_listings_on_user_id    (user_id)
#  index_listings_on_zipcode    (zipcode)
#

class Listing < ActiveRecord::Base
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # mapping do
  #   indexes :id, type: 'string', index: 'not_analyzed'
  #   indexes :spot_name, type: 'string', analyzer: 'kuromoji'
  #   indexes :address, type: 'string', analyzer: 'kuromoji'
  #   indexes :location, type: 'geo_point'
  # end

  belongs_to :user
  has_many :listing_images, dependent: :destroy
  has_one :confection, dependent: :destroy
  has_one :tool, dependent: :destroy
  has_one :dress_code, dependent: :destroy
  has_many :reservations
  has_many :reviews
  has_many :listing_ngevents, class_name: 'UserNgevent'
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :shop_categories, dependent: :destroy
  has_and_belongs_to_many :shop_services, dependent: :destroy
  # rubocop:enable Rails/HasAndBelongsToMany
  has_many :business_hours, dependent: :destroy
  has_many :weekday_business_hours
  has_one :holiday_business_hour
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :englishes, dependent: :destroy
  has_and_belongs_to_many :english_messages
  # rubocop:enable Rails/HasAndBelongsToMany

  mount_uploader :cover_image, DefaultImageUploader

  validates :user_id, presence: true
  validates :location, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :title, presence: true

  scope :mine, ->(user_id) { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :opened, -> { where(open: true) }
  scope :not_opened, -> { where(open: false) }
  scope :search_location, ->(location_sel) { where(location_sel) }
  scope :search_keywords, ->(keywords_sel) { where(keywords_sel) }
  scope :available_num_of_guest?, ->(num_of_guest) { where('capacity >= ?', num_of_guest) }
  scope :available_price_min?, ->(price_min) { where('price >= ?', price_min) }
  scope :available_price_max?, ->(price_max) { where('price <= ?', price_max) }

  class << self
    def search(search_params)
      listings = where(search_params[:shop_name].presence && [:title, :title_en].map { |field| arel_table[field].matches("%#{search_params[:shop_name]}%") }.inject(:or))
      [:shop_categories, :shop_services, :englishes].each do |category_name|
        if search_params[category_name].present?
          categories = Array(search_params[category_name]).reject(&:blank?).map(&:to_i)
          listings = listings.includes(category_name).where(category_name => {id: categories}) if categories.present?
        end
      end
      listings = listings.where(smoking_id: search_params[:smoking_id]) if search_params[:smoking_id].present?
      listings = listings.where(Listing.arel_table[:price].lteq(search_params[:price])) if search_params[:price].present?
      if search_params[:prefectures].present?
        pref = Prefecture.find(search_params[:prefectures].to_i)
        listings = listings.where([[:location, :name], [:location_en, :name_en]].map { |(field, name)| arel_table[field].matches("%#{pref[name]}%") }.inject(&:or))
      end
      listings
    end
  end

  def set_lon_lat
    hash = geocode_with_google_map_api
    if hash['success'] # .present?
      self.longitude = hash['lng']
      self.latitude = hash['lat']
      self
    else
      return false
    end
  end

  def geocode_with_google_map_api
    base_url = 'http://maps.google.com/maps/api/geocode/json'
    address = URI.encode(location)
    hash = {}
    req_url = "#{base_url}?address=#{address}&sensor=false&language=ja"
    response = Net::HTTP.get_response(URI.parse(req_url))
    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      unless data['results'][0].nil?
        hash['lat'] = data['results'][0]['geometry']['location']['lat']
        hash['lng'] = data['results'][0]['geometry']['location']['lng']
        hash['success'] = true
      else
        hash['lat'] = 0.00
        hash['lng'] = 0.00
        hash['success'] = false
      end
    else
      hash['lat'] = 0.00
      hash['lng'] = 0.00
      hash['success'] = false
    end
    hash
  end

  def current_user_bookmarked?(user_id)
    Favorite.exists?(user_id: user_id, listing_id: id)
  end

  def left_step_count_and_elements
    cs = complete_steps
    # return_array = [cs.count, cs]
    [cs.count, cs]
  end

  def complete_steps
    result = []
    result << Settings.left_steps.listing_image unless ListingImage.exists?(listing_id: id)
    # result << Settings.left_steps.confection unless Confection.exists?(listing_id: id)
    # result << Settings.left_steps.tool unless Tool.exists?(listing_id: id)
    # result << Settings.left_steps.dress_code unless DressCode.exists?(listing_id: id)
    result
  end

  def publish
    self.open = true
    save
  end

  def unpublish
    self.open = false
    save
  end
end
