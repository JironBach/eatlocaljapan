#!/bin/sh

scp -r -P 12321 js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public/* public_staging
scp -r -P 12321 bin/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/bin
scp -r -P 12321 public_staging/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public
chmod -R a+r app/assets
scp -r -P 12321 app/assets/*/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public/assets
cp config/deploy_staging.rb config/deploy.rb
cp Capfile_staging Capfile
bundle exec cap staging deploy --trace

