set :stage, :staging # environment name

# server-based syntax
# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}
# server 'git.mydns.jp', user: 'js', roles: %w{app db web}

# roles of servers
role :app, %w(eatlocaljapan@staging.eatlocaljapan.com) # , my_property: :my_value
role :web, %w(eatlocaljapan@staging.eatlocaljapan.com) # , other_property: :other_value
role :db,  %w(eatlocaljapan@staging.eatlocaljapan.com)

# information of servers
server \
  'staging.eatlocaljapan.com',
  user: 'eatlocaljapan',
  roles: %w(web app db),
  ssh_options: \
    {
      port: 22,
      user: 'eatlocaljapan',
      keys: %w(/Users/js/.ssh/eatlocaljapan.key),
      forward_agent: true,
      auth_methods: %w(publickey password)
      # password: 'please use keys'
    }
