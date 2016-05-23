#!/bin/sh

chmod -R a+r app/assets
scp -r eatlocaljapan@www.eatlocaljapan.com:~/www/staging/eatlocaljapan/current/shared/public/* public
scp -r public/* eatlocaljapan@www.eatlocaljapan.com:~/www/staging/eatlocaljapan/shared/public
scp -r app/assets/*/* eatlocaljapan@www.eatlocaljapan.com:~/www/staging/eatlocaljapan/current/shared/public/assets
git push origin develop:master
rm -f config/deploy.rb
cp config/deploy_production.rb config/deploy.rb
rm -f Capfile
cp Capfile_production Capfile
bundle exec cap production deploy --trace

