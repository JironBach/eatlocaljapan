#!/bin/sh

scp -r eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan//shared/public/* public_production
scp -r public_production/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public
scp -r bin/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/bin
chmod -R a+r app/assets
scp -r app/assets/*/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public/assets
cp config/deploy_production.rb config/deploy.rb
cp Capfile_production Capfile
bundle exec cap production deploy --trace

