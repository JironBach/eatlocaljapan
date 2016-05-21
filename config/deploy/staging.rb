set :stage, :staging #環境名

# server-based syntax
# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}
#server 'git.mydns.jp', user: 'js', roles: %w{app db web}

#各サーバの役割を記述
role :app, %w{js@jironbach.iobb.net}#, my_property: :my_value
role :web, %w{js@jironbach.iobb.net}#, other_property: :other_value
role :db,  %w{js@jironbach.iobb.net}

#サーバ情報記述
server 'jironbach.iobb.net',
user: 'js',
roles: %w{web app db},
  ssh_options: {
    port: 12321,
    user: 'js',
    keys: %w(/Users/js/.ssh/jironmac),
    forward_agent: true,
    auth_methods: %w(publickey password)
    # password: 'please use keys'
  }
