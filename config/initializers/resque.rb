Resque.redis = Redis.new(host: 'localhost', post: 6379)
Resque.after_fork = proc { ActiveRecord::Base.establish_connection }
