#!/bin/sh

chmod -R a+r app/assets
scp -P 12321 app/assets/*/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public/assets
rm -f config/deploy.rb
cp config/deploy_staging.rb config/deploy.rb
rm -f Capfile
cp Capfile_staging Capfile
bundle exec cap staging deploy --trace

