set :stage, :production #環境名

# server-based syntax
# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}
#server 'git.mydns.jp', user: 'js', roles: %w{app db web}

#各サーバの役割を記述
role :app, %w{eatlocaljapan@www.eatlocaljapan.com}#, my_property: :my_value
role :web, %w{eatlocaljapan@www.eatlocaljapan.com}#, other_property: :other_value
role :db,  %w{eatlocaljapan@www.eatlocaljapan.com}

#サーバ情報記述
server 'www.eatlocaljapan.com',
user: 'eatlocaljapan',
roles: %w{web app db},
  ssh_options: {
    port: 22,
    user: 'eatlocaljapan',
    keys: %w(/Users/js/.ssh/eatlocaljapan.key),
    forward_agent: true,
    auth_methods: %w(publickey password)
    # password: 'please use keys'
  }
