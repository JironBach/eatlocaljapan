# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.aaths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(*.sass *.scss *.woff *.eot *.svg *.ttf *.png *.jpg *.jpeg *.gif)

files = Dir[Rails.root.join('app', 'assets', 'javascripts', 'i18n', '*.js')]
files.map! { |file| file.sub(/#{Rails.root}\/app\/assets\/javascripts\//, '') }
Rails.application.config.assets.precompile += files
