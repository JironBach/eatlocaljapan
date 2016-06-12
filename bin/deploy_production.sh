#!/bin/sh

# 画像をバックアップ
scp -r eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public
# セッションの保存
scp -r eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan//shared/tmp/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/tmp
# binをアップロード
scp -r bin/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/bin
chmod -R a+r app/assets
# assetsをアップロード
scp -r app/assets/*/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public/assets
cp config/deploy_production.rb config/deploy.rb
cp Capfile_production Capfile
bundle exec cap production deploy --trace

