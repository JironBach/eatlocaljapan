#!/bin/sh

chmod -R a+r app/assets
scp -P 12321 bin/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/bin
scp -r -P 12321 app/assets/*/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public/assets
cp config/deploy_staging.rb config/deploy.rb
cp Capfile_staging Capfile
bundle exec cap staging deploy --trace

