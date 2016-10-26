require 'seed-fu/capistrano3'
require 'capistrano/bundler'

# config valid only for current version of Capistrano
lock '3.5.0'

# application name
set :application, 'eatlocaljapan'
# url of repository
set :repo_url, 'git@github.com:JironBach/eatlocaljapan.git'
# target branch to deploy
set :branch, 'develop'
# full path of directory to deploy
set :deploy_to, '/Users/js/www/staging/eatlocaljapan'
# version control system
set :scm, :git
# log level configuration
set :log_level, :debug
# keep configuration of below line, which is the configuration around sudo
set :pty, true
# configuration about resources under shared directory
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets public/uploads)
# keep configuration of below line, which is the configuration around bundler with capistrano
set :default_env, path: '/Users/js/.rbenv/shims:/Users/js/.rbenv/bin:$PATH'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.4'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)}" # #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value
set :rbenv_custom_path, '/usr/local/bin'

# retain 5th generation of releases
set :keep_releases, 5

set :passenger_environment_variables, path: '/Users/js/.rbenv/versions/2.2.4/bin/:$PATH'
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }

# task definications
namespace :deploy do # namespace for tasks
  # http://capistranorb.com/documentation/getting-started/flow/
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
    on roles(:app) do # fetch(:assets_roles)) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed_fu'
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
