#!/bin/sh

chmod -R a+r app/assets
scp -r app/assets/*/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public/assets
scp -r app/assets/* eatlocaljapan@www.eatlocaljapan.com:~/www/production/eatlocaljapan/shared/public/
git push origin develop:master
rm -f config/deploy.rb
cp config/deploy_production.rb config/deploy.rb
rm -f Capfile
cp Capfile_production Capfile
bundle exec cap production deploy --trace

