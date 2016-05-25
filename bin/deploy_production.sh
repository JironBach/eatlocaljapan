#!/bin/sh

scp -r -P 12321 eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan//shared/public/* public_production
scp -r -P 12321 public_production/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public
scp -r -P 12321 bin/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/bin
chmod -R a+r app/assets
scp -r -P 12321 app/assets/*/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public/assets
cp config/deploy_production.rb config/deploy.rb
cp Capfile_production Capfile
bundle exec cap production deploy --trace

