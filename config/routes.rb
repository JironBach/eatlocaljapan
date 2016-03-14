# == Route Map
#
#                                  Prefix Verb       URI Pattern                                                                   Controller#Action
#                  new_admin_user_session GET        /admin/login(.:format)                                                        active_admin/devise/sessions#new
#                      admin_user_session POST       /admin/login(.:format)                                                        active_admin/devise/sessions#create
#              destroy_admin_user_session DELETE|GET /admin/logout(.:format)                                                       active_admin/devise/sessions#destroy
#                     admin_user_password POST       /admin/password(.:format)                                                     active_admin/devise/passwords#create
#                 new_admin_user_password GET        /admin/password/new(.:format)                                                 active_admin/devise/passwords#new
#                edit_admin_user_password GET        /admin/password/edit(.:format)                                                active_admin/devise/passwords#edit
#                                         PATCH      /admin/password(.:format)                                                     active_admin/devise/passwords#update
#                                         PUT        /admin/password(.:format)                                                     active_admin/devise/passwords#update
#                              admin_root GET        /admin(.:format)                                                              admin/dashboard#index
#          batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)                                     admin/admin_users#batch_action
#                       admin_admin_users GET        /admin/admin_users(.:format)                                                  admin/admin_users#index
#                                         POST       /admin/admin_users(.:format)                                                  admin/admin_users#create
#                    new_admin_admin_user GET        /admin/admin_users/new(.:format)                                              admin/admin_users#new
#                   edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)                                         admin/admin_users#edit
#                        admin_admin_user GET        /admin/admin_users/:id(.:format)                                              admin/admin_users#show
#                                         PATCH      /admin/admin_users/:id(.:format)                                              admin/admin_users#update
#                                         PUT        /admin/admin_users/:id(.:format)                                              admin/admin_users#update
#                                         DELETE     /admin/admin_users/:id(.:format)                                              admin/admin_users#destroy
#                batch_action_admin_auths POST       /admin/auths/batch_action(.:format)                                           admin/auths#batch_action
#                             admin_auths GET        /admin/auths(.:format)                                                        admin/auths#index
#                                         POST       /admin/auths(.:format)                                                        admin/auths#create
#                          new_admin_auth GET        /admin/auths/new(.:format)                                                    admin/auths#new
#                         edit_admin_auth GET        /admin/auths/:id/edit(.:format)                                               admin/auths#edit
#                              admin_auth GET        /admin/auths/:id(.:format)                                                    admin/auths#show
#                                         PATCH      /admin/auths/:id(.:format)                                                    admin/auths#update
#                                         PUT        /admin/auths/:id(.:format)                                                    admin/auths#update
#                                         DELETE     /admin/auths/:id(.:format)                                                    admin/auths#destroy
#   batch_action_admin_browsing_histories POST       /admin/browsing_histories/batch_action(.:format)                              admin/browsing_histories#batch_action
#                admin_browsing_histories GET        /admin/browsing_histories(.:format)                                           admin/browsing_histories#index
#                                         POST       /admin/browsing_histories(.:format)                                           admin/browsing_histories#create
#              new_admin_browsing_history GET        /admin/browsing_histories/new(.:format)                                       admin/browsing_histories#new
#             edit_admin_browsing_history GET        /admin/browsing_histories/:id/edit(.:format)                                  admin/browsing_histories#edit
#                  admin_browsing_history GET        /admin/browsing_histories/:id(.:format)                                       admin/browsing_histories#show
#                                         PATCH      /admin/browsing_histories/:id(.:format)                                       admin/browsing_histories#update
#                                         PUT        /admin/browsing_histories/:id(.:format)                                       admin/browsing_histories#update
#                                         DELETE     /admin/browsing_histories/:id(.:format)                                       admin/browsing_histories#destroy
#          batch_action_admin_confections POST       /admin/confections/batch_action(.:format)                                     admin/confections#batch_action
#                       admin_confections GET        /admin/confections(.:format)                                                  admin/confections#index
#                                         POST       /admin/confections(.:format)                                                  admin/confections#create
#                    new_admin_confection GET        /admin/confections/new(.:format)                                              admin/confections#new
#                   edit_admin_confection GET        /admin/confections/:id/edit(.:format)                                         admin/confections#edit
#                        admin_confection GET        /admin/confections/:id(.:format)                                              admin/confections#show
#                                         PATCH      /admin/confections/:id(.:format)                                              admin/confections#update
#                                         PUT        /admin/confections/:id(.:format)                                              admin/confections#update
#                                         DELETE     /admin/confections/:id(.:format)                                              admin/confections#destroy
#                         admin_dashboard GET        /admin/dashboard(.:format)                                                    admin/dashboard#index
#          batch_action_admin_dress_codes POST       /admin/dress_codes/batch_action(.:format)                                     admin/dress_codes#batch_action
#                       admin_dress_codes GET        /admin/dress_codes(.:format)                                                  admin/dress_codes#index
#                                         POST       /admin/dress_codes(.:format)                                                  admin/dress_codes#create
#                    new_admin_dress_code GET        /admin/dress_codes/new(.:format)                                              admin/dress_codes#new
#                   edit_admin_dress_code GET        /admin/dress_codes/:id/edit(.:format)                                         admin/dress_codes#edit
#                        admin_dress_code GET        /admin/dress_codes/:id(.:format)                                              admin/dress_codes#show
#                                         PATCH      /admin/dress_codes/:id(.:format)                                              admin/dress_codes#update
#                                         PUT        /admin/dress_codes/:id(.:format)                                              admin/dress_codes#update
#                                         DELETE     /admin/dress_codes/:id(.:format)                                              admin/dress_codes#destroy
#          batch_action_admin_emergencies POST       /admin/emergencies/batch_action(.:format)                                     admin/emergencies#batch_action
#                       admin_emergencies GET        /admin/emergencies(.:format)                                                  admin/emergencies#index
#                                         POST       /admin/emergencies(.:format)                                                  admin/emergencies#create
#                     new_admin_emergency GET        /admin/emergencies/new(.:format)                                              admin/emergencies#new
#                    edit_admin_emergency GET        /admin/emergencies/:id/edit(.:format)                                         admin/emergencies#edit
#                         admin_emergency GET        /admin/emergencies/:id(.:format)                                              admin/emergencies#show
#                                         PATCH      /admin/emergencies/:id(.:format)                                              admin/emergencies#update
#                                         PUT        /admin/emergencies/:id(.:format)                                              admin/emergencies#update
#                                         DELETE     /admin/emergencies/:id(.:format)                                              admin/emergencies#destroy
#             batch_action_admin_listings POST       /admin/listings/batch_action(.:format)                                        admin/listings#batch_action
#                          admin_listings GET        /admin/listings(.:format)                                                     admin/listings#index
#                                         POST       /admin/listings(.:format)                                                     admin/listings#create
#                       new_admin_listing GET        /admin/listings/new(.:format)                                                 admin/listings#new
#                      edit_admin_listing GET        /admin/listings/:id/edit(.:format)                                            admin/listings#edit
#                           admin_listing GET        /admin/listings/:id(.:format)                                                 admin/listings#show
#                                         PATCH      /admin/listings/:id(.:format)                                                 admin/listings#update
#                                         PUT        /admin/listings/:id(.:format)                                                 admin/listings#update
#                                         DELETE     /admin/listings/:id(.:format)                                                 admin/listings#destroy
#       batch_action_admin_listing_images POST       /admin/listing_images/batch_action(.:format)                                  admin/listing_images#batch_action
#                    admin_listing_images GET        /admin/listing_images(.:format)                                               admin/listing_images#index
#                                         POST       /admin/listing_images(.:format)                                               admin/listing_images#create
#                 new_admin_listing_image GET        /admin/listing_images/new(.:format)                                           admin/listing_images#new
#                edit_admin_listing_image GET        /admin/listing_images/:id/edit(.:format)                                      admin/listing_images#edit
#                     admin_listing_image GET        /admin/listing_images/:id(.:format)                                           admin/listing_images#show
#                                         PATCH      /admin/listing_images/:id(.:format)                                           admin/listing_images#update
#                                         PUT        /admin/listing_images/:id(.:format)                                           admin/listing_images#update
#                                         DELETE     /admin/listing_images/:id(.:format)                                           admin/listing_images#destroy
#          batch_action_admin_listing_pvs POST       /admin/listing_pvs/batch_action(.:format)                                     admin/listing_pvs#batch_action
#                       admin_listing_pvs GET        /admin/listing_pvs(.:format)                                                  admin/listing_pvs#index
#                                         POST       /admin/listing_pvs(.:format)                                                  admin/listing_pvs#create
#                    new_admin_listing_pv GET        /admin/listing_pvs/new(.:format)                                              admin/listing_pvs#new
#                   edit_admin_listing_pv GET        /admin/listing_pvs/:id/edit(.:format)                                         admin/listing_pvs#edit
#                        admin_listing_pv GET        /admin/listing_pvs/:id(.:format)                                              admin/listing_pvs#show
#                                         PATCH      /admin/listing_pvs/:id(.:format)                                              admin/listing_pvs#update
#                                         PUT        /admin/listing_pvs/:id(.:format)                                              admin/listing_pvs#update
#                                         DELETE     /admin/listing_pvs/:id(.:format)                                              admin/listing_pvs#destroy
#             batch_action_admin_messages POST       /admin/messages/batch_action(.:format)                                        admin/messages#batch_action
#                          admin_messages GET        /admin/messages(.:format)                                                     admin/messages#index
#                                         POST       /admin/messages(.:format)                                                     admin/messages#create
#                       new_admin_message GET        /admin/messages/new(.:format)                                                 admin/messages#new
#                      edit_admin_message GET        /admin/messages/:id/edit(.:format)                                            admin/messages#edit
#                           admin_message GET        /admin/messages/:id(.:format)                                                 admin/messages#show
#                                         PATCH      /admin/messages/:id(.:format)                                                 admin/messages#update
#                                         PUT        /admin/messages/:id(.:format)                                                 admin/messages#update
#                                         DELETE     /admin/messages/:id(.:format)                                                 admin/messages#destroy
#      batch_action_admin_message_threads POST       /admin/message_threads/batch_action(.:format)                                 admin/message_threads#batch_action
#                   admin_message_threads GET        /admin/message_threads(.:format)                                              admin/message_threads#index
#                                         POST       /admin/message_threads(.:format)                                              admin/message_threads#create
#                new_admin_message_thread GET        /admin/message_threads/new(.:format)                                          admin/message_threads#new
#               edit_admin_message_thread GET        /admin/message_threads/:id/edit(.:format)                                     admin/message_threads#edit
#                    admin_message_thread GET        /admin/message_threads/:id(.:format)                                          admin/message_threads#show
#                                         PATCH      /admin/message_threads/:id(.:format)                                          admin/message_threads#update
#                                         PUT        /admin/message_threads/:id(.:format)                                          admin/message_threads#update
#                                         DELETE     /admin/message_threads/:id(.:format)                                          admin/message_threads#destroy
# batch_action_admin_message_thread_users POST       /admin/message_thread_users/batch_action(.:format)                            admin/message_thread_users#batch_action
#              admin_message_thread_users GET        /admin/message_thread_users(.:format)                                         admin/message_thread_users#index
#                                         POST       /admin/message_thread_users(.:format)                                         admin/message_thread_users#create
#           new_admin_message_thread_user GET        /admin/message_thread_users/new(.:format)                                     admin/message_thread_users#new
#          edit_admin_message_thread_user GET        /admin/message_thread_users/:id/edit(.:format)                                admin/message_thread_users#edit
#               admin_message_thread_user GET        /admin/message_thread_users/:id(.:format)                                     admin/message_thread_users#show
#                                         PATCH      /admin/message_thread_users/:id(.:format)                                     admin/message_thread_users#update
#                                         PUT        /admin/message_thread_users/:id(.:format)                                     admin/message_thread_users#update
#                                         DELETE     /admin/message_thread_users/:id(.:format)                                     admin/message_thread_users#destroy
#             batch_action_admin_profiles POST       /admin/profiles/batch_action(.:format)                                        admin/profiles#batch_action
#                          admin_profiles GET        /admin/profiles(.:format)                                                     admin/profiles#index
#                                         POST       /admin/profiles(.:format)                                                     admin/profiles#create
#                       new_admin_profile GET        /admin/profiles/new(.:format)                                                 admin/profiles#new
#                      edit_admin_profile GET        /admin/profiles/:id/edit(.:format)                                            admin/profiles#edit
#                           admin_profile GET        /admin/profiles/:id(.:format)                                                 admin/profiles#show
#                                         PATCH      /admin/profiles/:id(.:format)                                                 admin/profiles#update
#                                         PUT        /admin/profiles/:id(.:format)                                                 admin/profiles#update
#                                         DELETE     /admin/profiles/:id(.:format)                                                 admin/profiles#destroy
#       batch_action_admin_profile_images POST       /admin/profile_images/batch_action(.:format)                                  admin/profile_images#batch_action
#                    admin_profile_images GET        /admin/profile_images(.:format)                                               admin/profile_images#index
#                                         POST       /admin/profile_images(.:format)                                               admin/profile_images#create
#                 new_admin_profile_image GET        /admin/profile_images/new(.:format)                                           admin/profile_images#new
#                edit_admin_profile_image GET        /admin/profile_images/:id/edit(.:format)                                      admin/profile_images#edit
#                     admin_profile_image GET        /admin/profile_images/:id(.:format)                                           admin/profile_images#show
#                                         PATCH      /admin/profile_images/:id(.:format)                                           admin/profile_images#update
#                                         PUT        /admin/profile_images/:id(.:format)                                           admin/profile_images#update
#                                         DELETE     /admin/profile_images/:id(.:format)                                           admin/profile_images#destroy
#       batch_action_admin_profile_videos POST       /admin/profile_videos/batch_action(.:format)                                  admin/profile_videos#batch_action
#                    admin_profile_videos GET        /admin/profile_videos(.:format)                                               admin/profile_videos#index
#                                         POST       /admin/profile_videos(.:format)                                               admin/profile_videos#create
#                 new_admin_profile_video GET        /admin/profile_videos/new(.:format)                                           admin/profile_videos#new
#                edit_admin_profile_video GET        /admin/profile_videos/:id/edit(.:format)                                      admin/profile_videos#edit
#                     admin_profile_video GET        /admin/profile_videos/:id(.:format)                                           admin/profile_videos#show
#                                         PATCH      /admin/profile_videos/:id(.:format)                                           admin/profile_videos#update
#                                         PUT        /admin/profile_videos/:id(.:format)                                           admin/profile_videos#update
#                                         DELETE     /admin/profile_videos/:id(.:format)                                           admin/profile_videos#destroy
#         batch_action_admin_reservations POST       /admin/reservations/batch_action(.:format)                                    admin/reservations#batch_action
#                      admin_reservations GET        /admin/reservations(.:format)                                                 admin/reservations#index
#                                         POST       /admin/reservations(.:format)                                                 admin/reservations#create
#                   new_admin_reservation GET        /admin/reservations/new(.:format)                                             admin/reservations#new
#                  edit_admin_reservation GET        /admin/reservations/:id/edit(.:format)                                        admin/reservations#edit
#                       admin_reservation GET        /admin/reservations/:id(.:format)                                             admin/reservations#show
#                                         PATCH      /admin/reservations/:id(.:format)                                             admin/reservations#update
#                                         PUT        /admin/reservations/:id(.:format)                                             admin/reservations#update
#                                         DELETE     /admin/reservations/:id(.:format)                                             admin/reservations#destroy
#              batch_action_admin_reviews POST       /admin/reviews/batch_action(.:format)                                         admin/reviews#batch_action
#                           admin_reviews GET        /admin/reviews(.:format)                                                      admin/reviews#index
#                                         POST       /admin/reviews(.:format)                                                      admin/reviews#create
#                        new_admin_review GET        /admin/reviews/new(.:format)                                                  admin/reviews#new
#                       edit_admin_review GET        /admin/reviews/:id/edit(.:format)                                             admin/reviews#edit
#                            admin_review GET        /admin/reviews/:id(.:format)                                                  admin/reviews#show
#                                         PATCH      /admin/reviews/:id(.:format)                                                  admin/reviews#update
#                                         PUT        /admin/reviews/:id(.:format)                                                  admin/reviews#update
#                                         DELETE     /admin/reviews/:id(.:format)                                                  admin/reviews#destroy
#       batch_action_admin_review_replies POST       /admin/review_replies/batch_action(.:format)                                  admin/review_replies#batch_action
#                    admin_review_replies GET        /admin/review_replies(.:format)                                               admin/review_replies#index
#                                         POST       /admin/review_replies(.:format)                                               admin/review_replies#create
#                  new_admin_review_reply GET        /admin/review_replies/new(.:format)                                           admin/review_replies#new
#                 edit_admin_review_reply GET        /admin/review_replies/:id/edit(.:format)                                      admin/review_replies#edit
#                      admin_review_reply GET        /admin/review_replies/:id(.:format)                                           admin/review_replies#show
#                                         PATCH      /admin/review_replies/:id(.:format)                                           admin/review_replies#update
#                                         PUT        /admin/review_replies/:id(.:format)                                           admin/review_replies#update
#                                         DELETE     /admin/review_replies/:id(.:format)                                           admin/review_replies#destroy
#                batch_action_admin_tools POST       /admin/tools/batch_action(.:format)                                           admin/tools#batch_action
#                             admin_tools GET        /admin/tools(.:format)                                                        admin/tools#index
#                                         POST       /admin/tools(.:format)                                                        admin/tools#create
#                          new_admin_tool GET        /admin/tools/new(.:format)                                                    admin/tools#new
#                         edit_admin_tool GET        /admin/tools/:id/edit(.:format)                                               admin/tools#edit
#                              admin_tool GET        /admin/tools/:id(.:format)                                                    admin/tools#show
#                                         PATCH      /admin/tools/:id(.:format)                                                    admin/tools#update
#                                         PUT        /admin/tools/:id(.:format)                                                    admin/tools#update
#                                         DELETE     /admin/tools/:id(.:format)                                                    admin/tools#destroy
#                batch_action_admin_users POST       /admin/users/batch_action(.:format)                                           admin/users#batch_action
#                             admin_users GET        /admin/users(.:format)                                                        admin/users#index
#                                         POST       /admin/users(.:format)                                                        admin/users#create
#                          new_admin_user GET        /admin/users/new(.:format)                                                    admin/users#new
#                         edit_admin_user GET        /admin/users/:id/edit(.:format)                                               admin/users#edit
#                              admin_user GET        /admin/users/:id(.:format)                                                    admin/users#show
#                                         PATCH      /admin/users/:id(.:format)                                                    admin/users#update
#                                         PUT        /admin/users/:id(.:format)                                                    admin/users#update
#                                         DELETE     /admin/users/:id(.:format)                                                    admin/users#destroy
#                          admin_comments GET        /admin/comments(.:format)                                                     admin/comments#index
#                                         POST       /admin/comments(.:format)                                                     admin/comments#create
#                           admin_comment GET        /admin/comments/:id(.:format)                                                 admin/comments#show
#                 user_omniauth_authorize GET|POST   /users/auth/:provider(.:format)                                               users/omniauth_callbacks#passthru {:provider=>/facebook/}
#                  user_omniauth_callback GET|POST   /users/auth/:action/callback(.:format)                                        users/omniauth_callbacks#:action
#                             user_unlock POST       /users/unlock(.:format)                                                       devise/unlocks#create
#                         new_user_unlock GET        /users/unlock/new(.:format)                                                   devise/unlocks#new
#                                         GET        /users/unlock(.:format)                                                       devise/unlocks#show
#                      localized_omniauth GET        (/:locale)/omniauth/:provider(.:format)                                       users/omniauth#localized {:locale=>/en/}
#                        new_user_session GET        (/:locale)/users/sign_in(.:format)                                            users/sessions#new {:locale=>/en/}
#                            user_session POST       (/:locale)/users/sign_in(.:format)                                            users/sessions#create {:locale=>/en/}
#                    destroy_user_session DELETE     (/:locale)/users/sign_out(.:format)                                           users/sessions#destroy {:locale=>/en/}
#                           user_password POST       (/:locale)/users/password(.:format)                                           users/passwords#create {:locale=>/en/}
#                       new_user_password GET        (/:locale)/users/password/new(.:format)                                       users/passwords#new {:locale=>/en/}
#                      edit_user_password GET        (/:locale)/users/password/edit(.:format)                                      users/passwords#edit {:locale=>/en/}
#                                         PATCH      (/:locale)/users/password(.:format)                                           users/passwords#update {:locale=>/en/}
#                                         PUT        (/:locale)/users/password(.:format)                                           users/passwords#update {:locale=>/en/}
#                cancel_user_registration GET        (/:locale)/users/cancel(.:format)                                             users/registrations#cancel {:locale=>/en/}
#                       user_registration POST       (/:locale)/users(.:format)                                                    users/registrations#create {:locale=>/en/}
#                   new_user_registration GET        (/:locale)/users/sign_up(.:format)                                            users/registrations#new {:locale=>/en/}
#                  edit_user_registration GET        (/:locale)/users/edit(.:format)                                               users/registrations#edit {:locale=>/en/}
#                                         PATCH      (/:locale)/users(.:format)                                                    users/registrations#update {:locale=>/en/}
#                                         PUT        (/:locale)/users(.:format)                                                    users/registrations#update {:locale=>/en/}
#                                         DELETE     (/:locale)/users(.:format)                                                    users/registrations#destroy {:locale=>/en/}
#                       user_confirmation POST       (/:locale)/users/confirmation(.:format)                                       users/confirmations#create {:locale=>/en/}
#                   new_user_confirmation GET        (/:locale)/users/confirmation/new(.:format)                                   users/confirmations#new {:locale=>/en/}
#                                         GET        (/:locale)/users/confirmation(.:format)                                       users/confirmations#show {:locale=>/en/}
#                                         POST       (/:locale)/users/unlock(.:format)                                             devise/unlocks#create {:locale=>/en/}
#                                         GET        (/:locale)/users/unlock/new(.:format)                                         devise/unlocks#new {:locale=>/en/}
#                                         GET        (/:locale)/users/unlock(.:format)                                             devise/unlocks#show {:locale=>/en/}
#                   profile_profile_image GET        (/:locale)/profiles/:profile_id/profile_images/:id(.:format)                  profile_images#show {:locale=>/en/}
#                                 profile GET        (/:locale)/profiles/:id(.:format)                                             profiles#show {:locale=>/en/}
#                                         POST       (/:locale)/profile/profile_image(.:format)                                    profile_images#create {:locale=>/en/}
#               new_profile_profile_image GET        (/:locale)/profile/profile_image/new(.:format)                                profile_images#new {:locale=>/en/}
#              edit_profile_profile_image GET        (/:locale)/profile/profile_image/edit(.:format)                               profile_images#edit {:locale=>/en/}
#                                         PATCH      (/:locale)/profile/profile_image(.:format)                                    profile_images#update {:locale=>/en/}
#                                         PUT        (/:locale)/profile/profile_image(.:format)                                    profile_images#update {:locale=>/en/}
#                                         DELETE     (/:locale)/profile/profile_image(.:format)                                    profile_images#destroy {:locale=>/en/}
#                                         POST       (/:locale)/profile(.:format)                                                  profiles#create {:locale=>/en/}
#                             new_profile GET        (/:locale)/profile/new(.:format)                                              profiles#new {:locale=>/en/}
#                            edit_profile GET        (/:locale)/profile/edit(.:format)                                             profiles#edit {:locale=>/en/}
#                                         PATCH      (/:locale)/profile(.:format)                                                  profiles#update {:locale=>/en/}
#                                         PUT        (/:locale)/profile(.:format)                                                  profiles#update {:locale=>/en/}
#                                         DELETE     (/:locale)/profile(.:format)                                                  profiles#destroy {:locale=>/en/}
#                               dashboard GET        (/:locale)/dashboard(.:format)                                                dashboard#index {:locale=>/en/}
#      dashboard_host_reservation_manager GET        (/:locale)/dashboard/host_reservation_manager(.:format)                       dashboard#host_reservation_manager {:locale=>/en/}
#     dashboard_guest_reservation_manager GET        (/:locale)/dashboard/guest_reservation_manager(.:format)                      dashboard#guest_reservation_manager {:locale=>/en/}
#                         message_threads GET        (/:locale)/message_threads(.:format)                                          message_threads#index {:locale=>/en/}
#                                         POST       (/:locale)/message_threads(.:format)                                          message_threads#create {:locale=>/en/}
#                      new_message_thread GET        (/:locale)/message_threads/new(.:format)                                      message_threads#new {:locale=>/en/}
#                          message_thread GET        (/:locale)/message_threads/:id(.:format)                                      message_threads#show {:locale=>/en/}
#                                         PATCH      (/:locale)/message_threads/:id(.:format)                                      message_threads#update {:locale=>/en/}
#                                         PUT        (/:locale)/message_threads/:id(.:format)                                      message_threads#update {:locale=>/en/}
#                                         DELETE     (/:locale)/message_threads/:id(.:format)                                      message_threads#destroy {:locale=>/en/}
#                   send_message_messages POST       (/:locale)/messages/send_message(.:format)                                    messages#send_message {:locale=>/en/}
#                                messages GET        (/:locale)/messages(.:format)                                                 messages#index {:locale=>/en/}
#                                         POST       (/:locale)/messages(.:format)                                                 messages#create {:locale=>/en/}
#                             new_message GET        (/:locale)/messages/new(.:format)                                             messages#new {:locale=>/en/}
#                            edit_message GET        (/:locale)/messages/:id/edit(.:format)                                        messages#edit {:locale=>/en/}
#                                 message GET        (/:locale)/messages/:id(.:format)                                             messages#show {:locale=>/en/}
#                                         PATCH      (/:locale)/messages/:id(.:format)                                             messages#update {:locale=>/en/}
#                                         PUT        (/:locale)/messages/:id(.:format)                                             messages#update {:locale=>/en/}
#                                         DELETE     (/:locale)/messages/:id(.:format)                                             messages#destroy {:locale=>/en/}
#                         search_listings GET        (/:locale)/listings/search(.:format)                                          listings#search {:locale=>/en/}
#                  search_result_listings GET        (/:locale)/listings/search_result(.:format)                                   listings#search_result {:locale=>/en/}
#                                         GET        (/:locale)/listings/page/:page(.:format)                                      listings#index {:locale=>/en/}
#           manage_listing_listing_images GET        (/:locale)/listings/:listing_id/listing_images/manage(.:format)               listing_images#manage {:locale=>/en/}
#                  listing_listing_images POST       (/:locale)/listings/:listing_id/listing_images(.:format)                      listing_images#create {:locale=>/en/}
#                   listing_listing_image GET        (/:locale)/listings/:listing_id/listing_images/:id(.:format)                  listing_images#show {:locale=>/en/}
#                                         PATCH      (/:locale)/listings/:listing_id/listing_images/:id(.:format)                  listing_images#update {:locale=>/en/}
#                                         PUT        (/:locale)/listings/:listing_id/listing_images/:id(.:format)                  listing_images#update {:locale=>/en/}
#                                         DELETE     (/:locale)/listings/:listing_id/listing_images/:id(.:format)                  listing_images#destroy {:locale=>/en/}
#              manage_listing_dress_codes GET        (/:locale)/listings/:listing_id/dress_codes/manage(.:format)                  dress_codes#manage {:locale=>/en/}
#                     listing_dress_codes POST       (/:locale)/listings/:listing_id/dress_codes(.:format)                         dress_codes#create {:locale=>/en/}
#                      listing_dress_code GET        (/:locale)/listings/:listing_id/dress_codes/:id(.:format)                     dress_codes#show {:locale=>/en/}
#                                         PATCH      (/:locale)/listings/:listing_id/dress_codes/:id(.:format)                     dress_codes#update {:locale=>/en/}
#                                         PUT        (/:locale)/listings/:listing_id/dress_codes/:id(.:format)                     dress_codes#update {:locale=>/en/}
#                                         DELETE     (/:locale)/listings/:listing_id/dress_codes/:id(.:format)                     dress_codes#destroy {:locale=>/en/}
#              manage_listing_confections GET        (/:locale)/listings/:listing_id/confections/manage(.:format)                  confections#manage {:locale=>/en/}
#                     listing_confections POST       (/:locale)/listings/:listing_id/confections(.:format)                         confections#create {:locale=>/en/}
#                      listing_confection GET        (/:locale)/listings/:listing_id/confections/:id(.:format)                     confections#show {:locale=>/en/}
#                                         PATCH      (/:locale)/listings/:listing_id/confections/:id(.:format)                     confections#update {:locale=>/en/}
#                                         PUT        (/:locale)/listings/:listing_id/confections/:id(.:format)                     confections#update {:locale=>/en/}
#                                         DELETE     (/:locale)/listings/:listing_id/confections/:id(.:format)                     confections#destroy {:locale=>/en/}
#                    manage_listing_tools GET        (/:locale)/listings/:listing_id/tools/manage(.:format)                        tools#manage {:locale=>/en/}
#                           listing_tools POST       (/:locale)/listings/:listing_id/tools(.:format)                               tools#create {:locale=>/en/}
#                            listing_tool GET        (/:locale)/listings/:listing_id/tools/:id(.:format)                           tools#show {:locale=>/en/}
#                                         PATCH      (/:locale)/listings/:listing_id/tools/:id(.:format)                           tools#update {:locale=>/en/}
#                                         PUT        (/:locale)/listings/:listing_id/tools/:id(.:format)                           tools#update {:locale=>/en/}
#                                         DELETE     (/:locale)/listings/:listing_id/tools/:id(.:format)                           tools#destroy {:locale=>/en/}
#         manage_listing_listing_ngevents GET        (/:locale)/listings/:listing_id/listing_ngevents/manage(.:format)             listing_ngevents#manage {:locale=>/en/}
#         search_listing_listing_ngevents GET        (/:locale)/listings/:listing_id/listing_ngevents/search(.:format)             listing_ngevents#search {:locale=>/en/}
#                listing_listing_ngevents GET        (/:locale)/listings/:listing_id/listing_ngevents(.:format)                    listing_ngevents#index {:locale=>/en/}
#                                         POST       (/:locale)/listings/:listing_id/listing_ngevents(.:format)                    listing_ngevents#create {:locale=>/en/}
#             new_listing_listing_ngevent GET        (/:locale)/listings/:listing_id/listing_ngevents/new(.:format)                listing_ngevents#new {:locale=>/en/}
#            edit_listing_listing_ngevent GET        (/:locale)/listings/:listing_id/listing_ngevents/:id/edit(.:format)           listing_ngevents#edit {:locale=>/en/}
#                 listing_listing_ngevent GET        (/:locale)/listings/:listing_id/listing_ngevents/:id(.:format)                listing_ngevents#show {:locale=>/en/}
#                                         PATCH      (/:locale)/listings/:listing_id/listing_ngevents/:id(.:format)                listing_ngevents#update {:locale=>/en/}
#                                         PUT        (/:locale)/listings/:listing_id/listing_ngevents/:id(.:format)                listing_ngevents#update {:locale=>/en/}
#                                         DELETE     (/:locale)/listings/:listing_id/listing_ngevents/:id(.:format)                listing_ngevents#destroy {:locale=>/en/}
#                         listing_publish GET        (/:locale)/listings/:listing_id/publish(.:format)                             listings#publish {:locale=>/en/}
#                       listing_unpublish GET        (/:locale)/listings/:listing_id/unpublish(.:format)                           listings#unpublish {:locale=>/en/}
#                                listings GET        (/:locale)/listings(.:format)                                                 listings#index {:locale=>/en/}
#                                         POST       (/:locale)/listings(.:format)                                                 listings#create {:locale=>/en/}
#                             new_listing GET        (/:locale)/listings/new(.:format)                                             listings#new {:locale=>/en/}
#                            edit_listing GET        (/:locale)/listings/:id/edit(.:format)                                        listings#edit {:locale=>/en/}
#                                 listing GET        (/:locale)/listings/:id(.:format)                                             listings#show {:locale=>/en/}
#                                         PATCH      (/:locale)/listings/:id(.:format)                                             listings#update {:locale=>/en/}
#                                         PUT        (/:locale)/listings/:id(.:format)                                             listings#update {:locale=>/en/}
#                                         DELETE     (/:locale)/listings/:id(.:format)                                             listings#destroy {:locale=>/en/}
#      reservation_reviews_review_replies POST       (/:locale)/reservations/:reservation_id/reviews/review_replies(.:format)      review_replies#create {:locale=>/en/}
#  new_reservation_reviews_review_replies GET        (/:locale)/reservations/:reservation_id/reviews/review_replies/new(.:format)  review_replies#new {:locale=>/en/}
# edit_reservation_reviews_review_replies GET        (/:locale)/reservations/:reservation_id/reviews/review_replies/edit(.:format) review_replies#edit {:locale=>/en/}
#                                         GET        (/:locale)/reservations/:reservation_id/reviews/review_replies(.:format)      review_replies#show {:locale=>/en/}
#                                         PATCH      (/:locale)/reservations/:reservation_id/reviews/review_replies(.:format)      review_replies#update {:locale=>/en/}
#                                         PUT        (/:locale)/reservations/:reservation_id/reviews/review_replies(.:format)      review_replies#update {:locale=>/en/}
#                                         DELETE     (/:locale)/reservations/:reservation_id/reviews/review_replies(.:format)      review_replies#destroy {:locale=>/en/}
#                     reservation_reviews POST       (/:locale)/reservations/:reservation_id/reviews(.:format)                     reviews#create {:locale=>/en/}
#                 new_reservation_reviews GET        (/:locale)/reservations/:reservation_id/reviews/new(.:format)                 reviews#new {:locale=>/en/}
#                edit_reservation_reviews GET        (/:locale)/reservations/:reservation_id/reviews/edit(.:format)                reviews#edit {:locale=>/en/}
#                                         GET        (/:locale)/reservations/:reservation_id/reviews(.:format)                     reviews#show {:locale=>/en/}
#                                         PATCH      (/:locale)/reservations/:reservation_id/reviews(.:format)                     reviews#update {:locale=>/en/}
#                                         PUT        (/:locale)/reservations/:reservation_id/reviews(.:format)                     reviews#update {:locale=>/en/}
#                                         DELETE     (/:locale)/reservations/:reservation_id/reviews(.:format)                     reviews#destroy {:locale=>/en/}
#                            reservations POST       (/:locale)/reservations(.:format)                                             reservations#create {:locale=>/en/}
#                             reservation GET        (/:locale)/reservations/:id(.:format)                                         reservations#show {:locale=>/en/}
#                                         PATCH      (/:locale)/reservations/:id(.:format)                                         reservations#update {:locale=>/en/}
#                                         PUT        (/:locale)/reservations/:id(.:format)                                         reservations#update {:locale=>/en/}
#                                    root GET        /(:locale)(.:format)                                                          welcome#index {:locale=>/en/}
#

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users,
  skip: [
    :session,
    :password,
    :registration,
    :confirmation
  ],
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope '(:locale)', locale: /en/ do

    # We define here a route inside the locale thats just saves the current locale in the session
    get 'omniauth/:provider' => 'users/omniauth#localized', as: :localized_omniauth
    devise_for :users,
    skip: :omniauth_callbacks,
    controllers: {
      sessions:            'users/sessions',
      registrations:       'users/registrations',
      passwords:           'users/passwords',
      confirmations:       'users/confirmations'
    }

    resources :profiles, only: [:show] do
      resources :profile_images, only: [:show]
    end

    resource :profile, except: [:index, :show] do
      resource :profile_image, except: [:index, :show]
    end

  #  resources :auths

    get 'dashboard'                           => 'dashboard#index'
    get 'dashboard/host_reservation_manager'  => 'dashboard#host_reservation_manager'
    get 'dashboard/guest_reservation_manager' => 'dashboard#guest_reservation_manager'
    # get 'reviews'                             => 'profiles#review', as: 'user_review'
    # get 'introductions'                       => 'profiles#introduction', as: 'introduction'

    resources :message_threads, except: [:edit]

    resources :messages do
      collection do
        post 'send_message'
      end
    end

    resources :listings do
      collection do
        get 'search',        action: 'search'
        get 'search_result', action: 'search_result'
        get 'page/:page',    action: 'index'
      end
      resources :listing_images, only: [:show, :create, :update, :destroy] do
        get 'manage', on: :collection
      end
      #resources :listing_videos do
      #  get 'manage', on: :collection
      #end
      resources :dress_codes, only: [:show, :create, :update, :destroy] do
        get 'manage', on: :collection
      end
      resources :confections, only: [:show, :create, :update, :destroy]  do
        get 'manage', on: :collection
      end
      resources :tools, only: [:show, :create, :update, :destroy] do
        get 'manage', on: :collection
      end
      resources :listing_ngevents do
        get 'manage', on: :collection
        get 'search', on: :collection
      end
      get 'publish',   action: 'publish',   as: 'publish'
      get 'unpublish', action: 'unpublish', as: 'unpublish'
    end

    resources :reservations, only: [:show, :create, :update] do
      resource :reviews do
        resource :review_replies
      end
    end

    #resources :wishlists

    root 'welcome#index'
  end

end
