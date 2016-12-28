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

class Listing < ApplicationRecord
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # mapping do
  #   indexes :id, type: 'string', index: 'not_analyzed'
  #   indexes :spot_name, type: 'string', analyzer: 'kuromoji'
  #   indexes :address, type: 'string', analyzer: 'kuromoji'
  #   indexes :location, type: 'geo_point'
  # end

  belongs_to :user
  belongs_to :info_admin
  has_many :listing_images, dependent: :destroy
  has_one :confection, dependent: :destroy
  has_one :tool, dependent: :destroy
  has_one :dress_code, dependent: :destroy
  has_many :reservations
  has_many :reviews
  has_many :listing_ngevents, class_name: 'UserNgevent'
  has_many :listings_shop_categories, dependent: :destroy
  has_many :shop_categories, through: :listings_shop_categories
  has_many :listings_shop_services, dependent: :destroy
  has_many :shop_services, through: :listings_shop_services
  has_many :business_hours, dependent: :destroy
  has_many :weekday_business_hours
  has_one :holiday_business_hour
  has_many :englishes_listings, dependent: :destroy
  has_many :englishes, through: :englishes_listings
  has_many :english_messages_listings, dependent: :destroy
  has_many :english_messages, through: :english_messages_listings
  belongs_to :smoking

  accepts_nested_attributes_for :listings_shop_categories, allow_destroy: true
  accepts_nested_attributes_for :listings_shop_services, allow_destroy: true
  accepts_nested_attributes_for :englishes_listings, allow_destroy: true
  accepts_nested_attributes_for :english_messages_listings, allow_destroy: true
  accepts_nested_attributes_for :weekday_business_hours
  accepts_nested_attributes_for :holiday_business_hour

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

  enum from: {today: 0, a_day_ago: 1, two_days_ago: 2, three_days_ago: 3}
  enum \
    to: \
      {
        this_month: 0, next_month: 1, two_months_later: 2, three_months_later: 3, four_months_later: 4, five_months_later: 5, six_months_later: 6, seven_months_later: 7,
        eight_months_later: 8, nine_months_later: 9, ten_months_later: 10, eleven_months_later: 11, one_year_later: 12
      }

  def closed_days(first_day)
    ng_days = listing_ngevents.opened.holiday.around_month(first_day).flat_map(&:consecutive_days)
    holidays = !holiday_business_hour.is_open? && HolidayJp.between((today = Time.zone.today.since(self[:from].days)), today.since(self[:to].month)).map(&:date) || []
    w_days = weekday_business_hours.where(is_open: false).map(&:wday).compact
    {dates: ng_days | holidays, w_days: w_days}
  end

  def business_hour_on(schedule)
    HolidayJp.holiday?(schedule) ? holiday_business_hour : weekday_business_hours.find_by(wday: schedule.wday)
  end

  def busy_times(schedule)
    UserNgevent.on(schedule).map { |event| [event.start, event.end] } \
      << [(business_hour = business_hour_on(schedule)).lunch_break_start_hour, business_hour.lunch_break_end_hour]
  end

  def on_time(schedule)
    [(business_hour = business_hour_on(schedule)).start_hour, business_hour.end_hour - (reservation_time_unit || 15).minutes]
  end

  def free_spaces(schedule, requested_time)
    (capacity - (schedule && reservations.at(schedule, requested_time).map(&:occupied_frames).compact.inject(&:+) || 0)) * reservation_frame
  end

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
    result = geocode_with_google_map_api
    unless result['success'] # .present?
      nil
    else
      self.longitude = result['lng']
      self.latitude = result['lat']
      self
    end
  end

  def geocode_with_google_map_api
    base_url = 'http://maps.google.com/maps/api/geocode/json'
    address = URI.encode(location)
    result = {}
    req_url = "#{base_url}?address=#{address}&sensor=false&language=ja"
    response = Net::HTTP.get_response(URI.parse(req_url))
    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      unless data['results'][0].nil?
        result['lat'] = data['results'][0]['geometry']['location']['lat']
        result['lng'] = data['results'][0]['geometry']['location']['lng']
        result['success'] = true
      else
        result['lat'] = 0.00
        result['lng'] = 0.00
        result['success'] = false
      end
    else
      result['lat'] = 0.00
      result['lng'] = 0.00
      result['success'] = false
    end
    result
  end

  def easy_translate(prefix: nil, fields: [:description, :shop_description, :location, :recommended, :visit_benefits, :visit_benefits_another])
    assign_attributes \
      fields \
        .select { |field| attributes[field].present? && attributes[:"#{field}_en"].blank? }
        .inject({}) { |tranlated, field| translated[:"#{field}_en"] = [prefix, EasyTranslate.translate(attributes[field], to: :en)].compact.join(' ') }
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
