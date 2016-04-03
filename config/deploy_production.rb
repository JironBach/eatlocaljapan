require 'seed-fu/capistrano3'

# config valid only for current version of Capistrano
lock '3.4.0'

#アプリケーション名
set :application, 'eatlocaljapan'
#レポジトリURL
set :repo_url, 'git@github.com:JironBach/eatlocaljapan.git'
#対象ブランチ
set :branch, 'master'
#デプロイ先ディレクトリ フルパスで指定
set :deploy_to, '/home/eatlocaljapan/www/production/eatlocaljapan'
#バージョン管理方法 subverion, git, mercurial, cvs, bzrなど
set :scm, :git
#情報レベル info or debug
set :log_level, :info
#sudoに必要 これをtrueにするとssh -tで実行される
set :pty, true
#sharedに入るものを指定
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets public/uploads}
#capistrano用bundleするのに必要
set :default_env, { path: "/home/eatlocaljapan/.rbenv/shims:/home/eatlocaljapan/.rbenv/bin:$PATH" }
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.4'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)}" # #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
set :rbenv_custom_path, "/usr/local/bin"

#5回分のreleasesを保持する
set :keep_releases, 5

set :passenger_environment_variables, { path: '/home/js/.rbenv/versions/2.2.4/bin/:$PATH' }
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }

#タスク定義
namespace :deploy do #タスクnamespace
  #http://capistranorb.com/documentation/getting-started/flow/
  desc 'Restart application'
  task :database do
    on roles(:app) do
      execute "cp #{shared_path}/config/.env #{release_path}"
      execute "cp #{shared_path}/config/secrets.yml #{release_path}/config"
      execute "cp #{shared_path}/config/database.yml #{release_path}/config"
      execute "cp -r #{shared_path}/public/images #{release_path}/public"
      execute "cp -r #{shared_path}/public/javascripts #{release_path}/public"
      execute "cp -r #{shared_path}/public/stylesheets #{release_path}/public"
      execute "chmod -R +w #{shared_path}"
      execute "cp -r #{shared_path} /tmp/root"
    end
  end
  desc 'Restart application'
  task :restart_app do
    on roles(:app) do #fetch(:assets_roles)) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed_fu"
          set :passenger_restart_with_touch, true
          invoke 'passenger:restart'
        end
      end
    end
  end
end

before 'deploy:updated', 'deploy:database'
before 'deploy:restart', 'deploy:migrate'
after 'deploy:published', 'deploy:restart_app'
