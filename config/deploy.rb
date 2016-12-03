require 'capistrano/rbenv'
require 'capistrano/bundler'

# config valid only for current version of Capistrano
lock '3.6.1'

# application name
set :application, 'eatlocaljapan'
# url of repository
set :repo_url, 'ssh://git@github.com/bizitjapan/eatlocaljapan.git'
# target branch to deploy
set :branch, 'master'
# full path of directory to deploy
set :deploy_to, '/var/www/www.eatlocaljapan.com'
# version control system
set :scm, :git
# log level
set :log_level, :debug
# keep configuration of below line, which is the configuration around sudo
set :pty, true
# configuration about setting files under shared directory
set :linked_files, %w(.env config/database.yml config/secrets.yml)
# configuration about resources under shared directory
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets public/images public/javascripts public/stylesheets public/uploads)
# configuration for rbenv
set :rbenv_type, :system # or :system, depends on your rbenv setup
# in case you want to set ruby version from the file:
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value
# keep configuration of below line, which is the configuration around bundler with capistrano
set :default_env, path: "#{fetch(:rbenv_path)}/shims:#{fetch(:rbenv_path)}/bin:$PATH"

# retaion 5th generation of releases
set :keep_releases, 5

set :passenger_environment_variables, path: "#{fetch(:rbenv_path)}/versions/#{fetch(:rbenv_ruby)}/bin:$PATH"
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }

# task definication
namespace :deploy do # namespace for tasks
  # http://capistranorb.com/documentation/getting-started/flow/
  desc 'Restart application'
  task :restart_app do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          set :passenger_restart_with_touch, true
          invoke 'passenger:restart'
        end
      end
    end
  end
end

before 'deploy:restart', 'deploy:migrate'
after 'deploy:published', 'deploy:restart_app'
