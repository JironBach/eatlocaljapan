Payment.configure do |config|
  config.endpoint = ENV['GMO_ENDPOINT']
  config.shop_id = ENV['GMO_SHOP_ID']
  config.shop_key = ENV['GMO_SHOP_KEY']
  config.site_id = ENV['GMO_SITE_ID']
  config.site_key = ENV['GMO_SITE_KEY']
end
