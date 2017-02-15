# rubocop:disable Metrics/ModuleLength
module ApplicationHelper
  def default_meta_tags(request, title, description, keywords)
    {
      charset: Settings.charset,
      og: {
        title: t('meta_tags.og.title'),
        type: Settings.meta_tags.og.type,
        url: request.original_url,
        image: Settings.meta_tags.og.image,
        site_name: t('meta_tags.og.site_name'),
        description: t('meta_tags.og.description')
      },
      fb: {
        admins: Settings.meta_tags.fb.admins
      },
      title: full_title(title),
      description: full_description(description),
      keywords: full_keywords(keywords),
      author: t('meta_tags.author'),
      viewport: Settings.meta_tags.viewport,
      format: {
        detection: Settings.meta_tags.format.detection
      }
    }
  end

  def i18n_url_for(locale:, **params)
    url_for(params.merge(locale: locale == I18n.default_locale ? nil : locale))
  end

  def full_title(page_title)
    base_title = t('meta_tags.title.base_title')
    if page_title.empty?
      base_title
    else
      "#{page_title} #{t('meta_tags.title.separator')} #{base_title}"
    end
  end

  def full_description(page_description)
    base_description = t('meta_tags.description.base_description')
    if page_description.empty?
      base_description
    else
      page_description
    end
  end

  def full_keywords(page_words)
    base_words = t('meta_tags.keywords.base_keywords')
    if page_words.empty?
      base_words
    else
      page_words
    end
  end

  def listing_cover_image_url(listing_id)
    ci = Listing.find(listing_id)
    if ci.blank?
      ''
    else
      ci.cover_image
    end
  end

  def listing_name(listing_id)
    ci = Listing.find(listing_id)
    if ci.blank?
      ''
    else
      ci.title
    end
  end

  # TODO: fix
  def number_to_yen(number)
    number_to_currency(number, unit: '円', format: '%n%u')
  end

  def unread_messages
    Message.unread_messages(current_user).count
  end

  def user_id_to_user_obj(user_id)
    users = User.mine(user_id)
    if users.size.zero?
      false # todo
    else
      users[0]
    end
  end

  def review_count_of_host(host_id)
    results = Listing.mine(host_id).pluck('review_count')
    review_count = 0
    results.each do |result|
      review_count += result
    end
    review_count
  end

  def user_id_to_profile_image(user_id)
    result = ProfileImage.mine(user_id)
    result[0].try('image') || Settings.images.noimage2.url
  end

  def user_id_to_profile_image_thumb(user_id)
    result = ProfileImage.mine(user_id)
    result[0].try('image').thumb || Settings.images.noimage2.url
  end

  def host_image(host_image_obj)
    host_image_obj.try('image') || Settings.images.noimage2.url
  end

  def profile_image
    if profile_image = ProfileImage.where(user_id: current_user.id).first
      profile_image.try('image') || Settings.images.noimage2.url
    else
      return Settings.images.noimage2.url
    end
  end

  def profile_image_thumb
    if profile_image = ProfileImage.where(user_id: current_user.id).first
      profile_image.try('image').thumb || Settings.images.noimage2.url
    else
      return Settings.images.noimage2.url
    end
  end

  def profile_image_exists?
    ProfileImage.exists?(user_id: current_user.id, profile_id: current_user.profile.id)
  end

  def new_or_edit_path(obj)
    obj ? edit_listing_path(obj) : new_listing_path(obj)
  end

  def left_step_count_and_elements(listing)
    listing.left_step_count_and_elements
  end

  def reservation_to_listing(reservation)
    Listing.find(reservation.listing_id)
  end

  def reservation_to_host(reservation)
    User.find(reservation.host_id)
  end

  def reservation_to_guest(reservation)
    User.find(reservation.guest_id)
  end

  def listing_id_to_weekly_pv(listing_id)
    ListingPv.weekly_pv(listing_id)
  end

  def new_reservations_came(user_id)
    Reservation.new_requests(user_id).count
  end

  def new_messages_came(user_id)
    MessageThread.unreads(User.find(user_id)).count
  end

  def counterpart_user_id(message_thread_id)
    MessageThreadUser.counterpart_user(message_thread_id, current_user.id)
  end

  def counterpart_user_obj(message_thread_id)
    user_id = MessageThreadUser.counterpart_user(message_thread_id, current_user.id)
    User.find(user_id)
  end

  def latest_message(message_thread_id)
    Message.message_thread(message_thread_id).last
  end

  def listing_id_to_listing_obj(listing_id)
    Listing.find(listing_id)
  end

  def reservation_id_to_reservation_obj(reservation_id)
    Reservation.find(reservation_id)
  end

  def reservation_id_to_messages(reservation_id)
    Message.reservation(reservation_id)
  end

  def profile_image_link
    profile_image = ProfileImage.where(user_id: current_user.id, profile_id: current_user.profile.id).first
    if profile_image.present?
      edit_profile_profile_image_path(current_user.profile.id, profile_image.id)
    else
      new_profile_profile_image_path(current_user.profile.id)
    end
  end

  def each_manager_link(reservation)
    if current_user.id == reservation.host_id
      dashboard_host_reservation_manager_path
    elsif current_user.id == reservation.guest_id
      dashboard_guest_reservation_manager_path
    end
  end

  def string_of_read(read, sender_flg)
    if read
      t 'message.read.string'
    else
      t 'message.unread.string'
    end
  end

  def review_id_to_review_reply_msg(review_id)
    rr = ReviewReply.where(review_id: review_id).select('msg').first
    if rr.present?
      rr.msg
    else
      ''
    end
  end

  def sender?(user_id, from_user_id)
    Rails.logger.info(user_id)
    Rails.logger.info(from_user_id)
    user_id != from_user_id
  end

  def nl2br(str)
    str.gsub(/\r\n|\r|\n/, '<br />')
  end
end
# rubocop:enable Metrics/ModuleLength
