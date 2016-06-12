#!/bin/sh

# 画像をバックアップ
scp -r -P 12321 js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public
# セッションの保存
scp -r -P 12321 js@jironbach.iobb.net:~/www/production/eatlocaljapan/shared/tmp/* js@jironbach.iobb.net:~/www/production/eatlocaljapan/shared/tmp
# binをアップロード
scp -r -P 12321 bin/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/bin
chmod -R a+r app/assets
scp -r -P 12321 app/assets/*/* js@jironbach.iobb.net:~/www/staging/eatlocaljapan/shared/public/assets
cp config/deploy_staging.rb config/deploy.rb
cp Capfile_staging Capfile
bundle exec cap staging deploy --trace

