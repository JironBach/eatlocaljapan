# == Schema Information
#
# Table name: listings
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  review_count           :integer          default(0)
#  ave_total              :float            default(0.0)
#  ave_accuracy           :float            default(0.0)
#  ave_communication      :float            default(0.0)
#  ave_cleanliness        :float            default(0.0)
#  ave_location           :float            default(0.0)
#  ave_check_in           :float            default(0.0)
#  ave_cost_performance   :float            default(0.0)
#  open                   :boolean          default(FALSE)
#  zipcode                :string(255)
#  location               :string(255)      default("")
#  longitude              :decimal(9, 6)    default(0.0)
#  latitude               :decimal(9, 6)    default(0.0)
#  delivery_flg           :boolean          default(FALSE)
#  price                  :integer          default(0)
#  description            :text
#  title                  :string(255)      default("")
#  capacity               :integer          default(0)
#  direction              :text
#  cover_image            :string(255)      default("")
#  cover_image_caption    :string(255)      default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  address                :string
#  smoking_id             :integer
#  shop_description       :text
#  shop_description_en    :text
#  price_low              :integer
#  price_high             :integer
#  tel                    :string
#  url                    :string
#  review_url             :string
#  recommended            :text
#  recommended_en         :text
#  visit_benefits         :string
#  visit_benefits_another :string
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
=begin
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
    indexes :id, type: 'string', index: 'not_analyzed'
    indexes :spot_name, type: 'string', analyzer: 'kuromoji'
    indexes :address, type: 'string', analyzer: 'kuromoji'
    indexes :location, type: 'geo_point'
  end
=end

  belongs_to :user
  has_many :listing_images, dependent: :destroy
  has_one :confection, dependent: :destroy
  has_one :tool, dependent: :destroy
  has_one :dress_code, dependent: :destroy
  has_many :reservations
  has_many :reviews
  has_many :listing_ngevents, class_name: "UserNgevent"
  has_many :shop_categories, dependent: :destroy
  has_many :shop_services, dependent: :destroy
  has_one :smoking
  has_many :english, dependent: :destroy
  has_many :business_hours, dependent: :destroy

  mount_uploader :cover_image, DefaultImageUploader

  validates :user_id, presence: true
  validates :location, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :price, presence: true
  validates :title, presence: true
  validates :capacity, presence: true

  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :opened, -> { where(open: true) }
  scope :not_opened, -> { where(open: false) }
  scope :search_location, -> location_sel { where(location_sel) }
  scope :search_keywords, -> keywords_sel { where(keywords_sel) }
  scope :available_num_of_guest?, -> num_of_guest { where("capacity >= ?", num_of_guest) }
  scope :available_price_min?, -> price_min { where("price >= ?", price_min) }
  scope :available_price_max?, -> price_max { where("price <= ?", price_max) }

  def set_lon_lat
    hash = self.geocode_with_google_map_api
    if hash['success'].present?
      self.longitude = hash['lng']
      self.latitude = hash['lat']
      self
    else
      return false
    end
  end

  def geocode_with_google_map_api
    base_url = "http://maps.google.com/maps/api/geocode/json"
    address = URI.encode(self.location)
    hash = Hash.new
    reqUrl = "#{base_url}?address=#{address}&sensor=false&language=ja"
    response = Net::HTTP.get_response(URI.parse(reqUrl))
    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      hash['lat'] = data['results'][0]['geometry']['location']['lat']
      hash['lng'] = data['results'][0]['geometry']['location']['lng']
      hash['success'] = true
    else
      hash['lat'] = 0.00
      hash['lng'] = 0.00
      hash['success'] = false
    end
    hash
  end

  def self.search(search_params)
    location = Listing.arel_table['location']
    location_sel = location.matches("\%#{search_params["location"]}\%")
    if search_params['where'] == 'top' || search_params['where'] == 'header'
      listing = Listing.search_location(location_sel).available_num_of_guest?(search_params['num_of_guest'])
      if search_params['schedule'].present?
        listing = listing.where( UserNgevent.enable_search_condition( DateTime.parse(search_params['schedule']) ).exists.not )
      end
      listing
    elsif search_params['where'] == 'listing_search'
      # tba: schedule
      price = search_params['price'].split(',')
      price_min = price[0].to_i
      price_max = price[1].to_i
      keywords = Listing.arel_table['description']
      keywords_sel = keywords.matches("\%#{search_params["keywords"]}\%")
      if search_params['wafuku'].present?
        Listing.search_location(location_sel)
               .available_num_of_guest?(search_params['num_of_guest'])
               .available_price_min?(price_min)
               .available_price_max?(price_max)
               .joins{ dress_code.outer }.where{ (dress_code.wafuku == search_params['wafuku']) }
               .search_keywords(keywords_sel)
      else
        Listing.search_location(location_sel)
               .available_num_of_guest?(search_params['num_of_guest'])
               .available_price_min?(price_min)
               .available_price_max?(price_max)
               .search_keywords(keywords_sel)
      end
    end
  end



  def current_user_bookmarked?(user_id)
    Favorite.exists?(user_id: user_id, listing_id: self.id)
  end

  def left_step_count_and_elements
    cs = self.complete_steps
    #return_array = [cs.count, cs]
    [cs.count, cs]
  end

  def complete_steps
    result = []
    result << Settings.left_steps.listing_image unless ListingImage.exists?(listing_id: self.id)
    result << Settings.left_steps.confection unless Confection.exists?(listing_id: self.id)
    result << Settings.left_steps.tool unless Tool.exists?(listing_id: self.id)
    result << Settings.left_steps.dress_code unless DressCode.exists?(listing_id: self.id)
    result
  end

  def publish
    self.open = true
    self.save
  end

  def unpublish
    self.open = false
    self.save
  end
end
