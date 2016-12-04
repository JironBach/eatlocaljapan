set :stage, :staging # environment name

# server-based syntax
# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}
# server 'git.mydns.jp', user: 'js', roles: %w{app db web}

# roles of servers
role :app, %w(www@eatlocaljapan-application-staging-a) # , my_property: :my_value
role :web, %w(www@eatlocaljapan-application-staging-a) # , other_property: :other_value
role :db,  %w()
