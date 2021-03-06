# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170113072645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "auths", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "auths", ["user_id"], name: "index_auths_on_user_id", using: :btree

  create_table "browsing_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "viewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "browsing_histories", ["listing_id"], name: "index_browsing_histories_on_listing_id", using: :btree
  add_index "browsing_histories", ["user_id"], name: "index_browsing_histories_on_user_id", using: :btree
  add_index "browsing_histories", ["viewed_at"], name: "index_browsing_histories_on_viewed_at", using: :btree

  create_table "business_hours", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "listing_id"
    t.integer  "wday"
    t.boolean  "is_open",                default: true,  null: false
    t.time     "start_hour"
    t.time     "end_hour"
    t.string   "type"
    t.time     "lunch_break_start_hour"
    t.time     "lunch_break_end_hour"
    t.boolean  "has_lunch_break",        default: false, null: false
  end

  add_index "business_hours", ["listing_id", "wday"], name: "index_business_hours_on_listing_id_and_wday", using: :btree

  create_table "charges", force: :cascade do |t|
    t.integer  "service_id"
    t.string   "type"
    t.string   "charger_type"
    t.integer  "charger_id"
    t.string   "payment_method_type"
    t.integer  "payment_method_id"
    t.integer  "status",              default: 0
    t.integer  "order_no"
    t.date     "expiration_date"
    t.datetime "ordered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confections", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "name",                    null: false
    t.string   "url",        default: ""
    t.string   "image",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "confections", ["listing_id", "name"], name: "index_confections_on_listing_id_and_name", unique: true, using: :btree
  add_index "confections", ["listing_id"], name: "index_confections_on_listing_id", using: :btree

  create_table "dress_codes", force: :cascade do |t|
    t.integer  "listing_id"
    t.boolean  "wafuku",     default: false
    t.text     "note",       default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "dress_codes", ["listing_id"], name: "index_dress_codes_on_listing_id", using: :btree

  create_table "emergencies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.string   "name",         null: false
    t.string   "phone"
    t.string   "email"
    t.string   "relationship", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "emergencies", ["profile_id"], name: "index_emergencies_on_profile_id", using: :btree
  add_index "emergencies", ["user_id"], name: "index_emergencies_on_user_id", using: :btree

  create_table "english_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "name_en"
  end

  create_table "english_messages_listings", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "listing_id",         null: false
    t.integer  "english_message_id", null: false
  end

  create_table "englishes", force: :cascade do |t|
    t.string "name",    null: false
    t.string "name_en", null: false
  end

  create_table "englishes_listings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id", null: false
    t.integer  "english_id", null: false
  end

  add_index "englishes_listings", ["listing_id", "english_id"], name: "index_englishes_listings_on_listing_id_and_english_id", unique: true, using: :btree

  create_table "info_admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "name_en"
  end

  create_table "listing_images", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "image",      default: ""
    t.integer  "order_num"
    t.string   "caption",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "listing_images", ["listing_id"], name: "index_listing_images_on_listing_id", using: :btree

  create_table "listing_pvs", force: :cascade do |t|
    t.integer  "listing_id"
    t.date     "viewed_at"
    t.integer  "pv",         default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "listing_pvs", ["listing_id"], name: "index_listing_pvs_on_listing_id", using: :btree
  add_index "listing_pvs", ["viewed_at", "listing_id"], name: "index_listing_pvs_on_viewed_at_and_listing_id", unique: true, using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_count",                                      default: 0
    t.float    "ave_total",                                         default: 0.0
    t.float    "ave_accuracy",                                      default: 0.0
    t.float    "ave_communication",                                 default: 0.0
    t.float    "ave_cleanliness",                                   default: 0.0
    t.float    "ave_location",                                      default: 0.0
    t.float    "ave_check_in",                                      default: 0.0
    t.float    "ave_cost_performance",                              default: 0.0
    t.boolean  "open",                                              default: false
    t.string   "zipcode"
    t.string   "location",                                          default: ""
    t.decimal  "longitude",                 precision: 9, scale: 6, default: 0.0
    t.decimal  "latitude",                  precision: 9, scale: 6, default: 0.0
    t.boolean  "delivery_flg",                                      default: false
    t.integer  "price",                                             default: 0
    t.text     "description",                                       default: ""
    t.string   "title",                                             default: ""
    t.integer  "capacity",                                          default: 0
    t.text     "direction",                                         default: ""
    t.string   "cover_image",                                       default: ""
    t.string   "cover_image_caption",                               default: ""
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "smoking_id"
    t.text     "business_hours_remarks"
    t.text     "shop_description"
    t.text     "shop_description_en"
    t.integer  "price_low"
    t.integer  "price_high"
    t.string   "tel"
    t.string   "url"
    t.string   "review_url"
    t.text     "recommended"
    t.text     "recommended_en"
    t.string   "visit_benefits"
    t.string   "visit_benefits_another"
    t.string   "title_en"
    t.integer  "price_low_dinner"
    t.integer  "price_high_dinner"
    t.integer  "english_message_id"
    t.integer  "info_admin_id"
    t.string   "link_tabelog"
    t.string   "link_yelp"
    t.string   "link_tripadvisor"
    t.text     "description_en"
    t.string   "location_en"
    t.string   "visit_benefits_en"
    t.string   "visit_benefits_another_en"
    t.integer  "reservation_frame"
    t.integer  "unit"
    t.integer  "from"
    t.integer  "to"
    t.integer  "reservation_time_unit"
  end

  add_index "listings", ["capacity"], name: "index_listings_on_capacity", using: :btree
  add_index "listings", ["latitude"], name: "index_listings_on_latitude", using: :btree
  add_index "listings", ["location"], name: "index_listings_on_location", using: :btree
  add_index "listings", ["longitude"], name: "index_listings_on_longitude", using: :btree
  add_index "listings", ["price"], name: "index_listings_on_price", using: :btree
  add_index "listings", ["title"], name: "index_listings_on_title", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree
  add_index "listings", ["zipcode"], name: "index_listings_on_zipcode", using: :btree

  create_table "listings_business_hours", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "listing_id",       null: false
    t.integer  "business_hour_id", null: false
  end

  add_index "listings_business_hours", ["listing_id", "business_hour_id"], name: "index_listing_business_hours", unique: true, using: :btree

  create_table "listings_shop_categories", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "listing_id",       null: false
    t.integer  "shop_category_id", null: false
  end

  add_index "listings_shop_categories", ["listing_id", "shop_category_id"], name: "index_listing_shop_categories", unique: true, using: :btree

  create_table "listings_shop_services", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "listing_id",      null: false
    t.integer  "shop_service_id", null: false
  end

  add_index "listings_shop_services", ["listing_id", "shop_service_id"], name: "index_listings_shop_services_on_listing_id_and_shop_service_id", unique: true, using: :btree

  create_table "menus", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "listing_id",     null: false
    t.string   "menu",           null: false
    t.string   "menu_en"
    t.string   "description"
    t.string   "description_en"
  end

  create_table "message_thread_users", force: :cascade do |t|
    t.integer  "message_thread_id", null: false
    t.integer  "user_id",           null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "message_thread_users", ["message_thread_id", "user_id"], name: "index_message_thread_users_on_message_thread_id_and_user_id", unique: true, using: :btree
  add_index "message_thread_users", ["message_thread_id"], name: "index_message_thread_users_on_message_thread_id", using: :btree
  add_index "message_thread_users", ["user_id"], name: "index_message_thread_users_on_user_id", using: :btree

  create_table "message_threads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "message_thread_id",                 null: false
    t.integer  "from_user_id",                      null: false
    t.integer  "to_user_id",                        null: false
    t.text     "content",           default: "",    null: false
    t.boolean  "read",              default: false
    t.datetime "read_at"
    t.integer  "listing_id",        default: 0,     null: false
    t.integer  "reservation_id",    default: 0,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "messages", ["from_user_id"], name: "index_messages_on_from_user_id", using: :btree
  add_index "messages", ["listing_id"], name: "index_messages_on_listing_id", using: :btree
  add_index "messages", ["message_thread_id"], name: "index_messages_on_message_thread_id", using: :btree
  add_index "messages", ["reservation_id"], name: "index_messages_on_reservation_id", using: :btree
  add_index "messages", ["to_user_id"], name: "index_messages_on_to_user_id", using: :btree

  create_table "payment_methods", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.integer  "gmo_card_seq"
    t.datetime "registered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_no"
    t.string   "expired_on"
  end

  create_table "prefectures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "name_en",    null: false
  end

  create_table "profile_images", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.string   "image",      default: "", null: false
    t.string   "caption",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "profile_images", ["profile_id"], name: "index_profile_images_on_profile_id", using: :btree
  add_index "profile_images", ["user_id"], name: "index_profile_images_on_user_id", using: :btree

  create_table "profile_videos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.string   "video",      default: "", null: false
    t.string   "caption",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "profile_videos", ["profile_id"], name: "index_profile_videos_on_profile_id", using: :btree
  add_index "profile_videos", ["user_id"], name: "index_profile_videos_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.string   "first_name",           default: ""
    t.string   "last_name",            default: ""
    t.date     "birthday"
    t.integer  "gender"
    t.string   "phone",                default: ""
    t.boolean  "phone_verification",   default: false
    t.string   "zipcode",              default: ""
    t.string   "location",             default: ""
    t.text     "self_introduction",    default: ""
    t.string   "school",               default: ""
    t.string   "work",                 default: ""
    t.string   "timezone",             default: ""
    t.integer  "listing_count",        default: 0
    t.integer  "wishlist_count",       default: 0
    t.integer  "bookmark_count",       default: 0
    t.integer  "reviewed_count",       default: 0
    t.integer  "reservation_count",    default: 0
    t.float    "ave_total",            default: 0.0
    t.float    "ave_accuracy",         default: 0.0
    t.float    "ave_communication",    default: 0.0
    t.float    "ave_cleanliness",      default: 0.0
    t.float    "ave_location",         default: 0.0
    t.float    "ave_check_in",         default: 0.0
    t.float    "ave_cost_performance", default: 0.0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "host_id"
    t.integer  "guest_id"
    t.integer  "listing_id"
    t.date     "schedule",                            null: false
    t.integer  "num_of_people",                       null: false
    t.text     "msg",                    default: ""
    t.integer  "progress",               default: 0,  null: false
    t.text     "reason",                 default: ""
    t.datetime "review_mail_sent_at"
    t.datetime "review_expiration_date"
    t.datetime "review_landed_at"
    t.datetime "reviewed_at"
    t.datetime "reply_mail_sent_at"
    t.datetime "reply_landed_at"
    t.datetime "replied_at"
    t.datetime "review_opened_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.time     "time"
    t.integer  "reservation_time_unit"
    t.boolean  "in_english"
  end

  add_index "reservations", ["guest_id"], name: "index_reservations_on_guest_id", using: :btree
  add_index "reservations", ["host_id"], name: "index_reservations_on_host_id", using: :btree
  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree

  create_table "review_replies", force: :cascade do |t|
    t.integer  "review_id"
    t.text     "msg",        default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "review_replies", ["review_id"], name: "index_review_replies_on_review_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "host_id"
    t.integer  "reservation_id"
    t.integer  "listing_id"
    t.integer  "accuracy",         default: 0
    t.integer  "communication",    default: 0
    t.integer  "cleanliness",      default: 0
    t.integer  "location",         default: 0
    t.integer  "check_in",         default: 0
    t.integer  "cost_performance", default: 0
    t.integer  "total",            default: 0
    t.text     "msg",              default: ""
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "reviews", ["guest_id"], name: "index_reviews_on_guest_id", using: :btree
  add_index "reviews", ["host_id"], name: "index_reviews_on_host_id", using: :btree
  add_index "reviews", ["listing_id"], name: "index_reviews_on_listing_id", using: :btree
  add_index "reviews", ["reservation_id"], name: "index_reviews_on_reservation_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "name_en"
    t.string   "code"
    t.integer  "charge_type", default: 0
    t.integer  "amount"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shop_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "name_en",    null: false
  end

  create_table "shop_services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "name_en",    null: false
  end

  create_table "smokings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "name_en",    null: false
  end

  create_table "tools", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "name",                    null: false
    t.string   "url",        default: ""
    t.string   "image",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "tools", ["listing_id", "name"], name: "index_tools_on_listing_id_and_name", unique: true, using: :btree
  add_index "tools", ["listing_id"], name: "index_tools_on_listing_id", using: :btree

  create_table "user_ngevents", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.integer  "reservation_id"
    t.integer  "reason",                        null: false
    t.datetime "start",                         null: false
    t.datetime "end",                           null: false
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "user_ngevents", ["listing_id"], name: "index_user_ngevents_on_listing_id", using: :btree
  add_index "user_ngevents", ["reservation_id"], name: "index_user_ngevents_on_reservation_id", using: :btree
  add_index "user_ngevents", ["user_id"], name: "index_user_ngevents_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid",                    default: "",    null: false
    t.string   "provider",               default: "",    null: false
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.integer  "profile_id"
    t.integer  "gmo_member_seq",         default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wishlists", ["user_id", "name"], name: "index_wishlists_on_user_id_and_name", unique: true, using: :btree
  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id", using: :btree

  add_foreign_key "auths", "users"
  add_foreign_key "browsing_histories", "listings"
  add_foreign_key "confections", "listings"
  add_foreign_key "dress_codes", "listings"
  add_foreign_key "emergencies", "profiles"
  add_foreign_key "emergencies", "users"
  add_foreign_key "listing_images", "listings"
  add_foreign_key "listing_pvs", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "message_thread_users", "message_threads"
  add_foreign_key "message_thread_users", "users"
  add_foreign_key "messages", "message_threads"
  add_foreign_key "messages", "users", column: "from_user_id"
  add_foreign_key "messages", "users", column: "to_user_id"
  add_foreign_key "profile_images", "profiles"
  add_foreign_key "profile_images", "users"
  add_foreign_key "profile_videos", "profiles"
  add_foreign_key "profile_videos", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users", column: "guest_id"
  add_foreign_key "reservations", "users", column: "host_id"
  add_foreign_key "review_replies", "reviews"
  add_foreign_key "reviews", "listings"
  add_foreign_key "reviews", "reservations"
  add_foreign_key "reviews", "users", column: "guest_id"
  add_foreign_key "reviews", "users", column: "host_id"
  add_foreign_key "tools", "listings"
  add_foreign_key "user_ngevents", "listings"
  add_foreign_key "user_ngevents", "reservations"
  add_foreign_key "user_ngevents", "users"
  add_foreign_key "wishlists", "users"
end
