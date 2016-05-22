#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

if Dir.pwd[-3..-1] == 'bin'
  puts 'アプリケーションのrootディレクトリで実行してください。'
  return
end

backup_to = "bin/data/#{Time.now.strftime("%j%H%M%S")}.stg"
`pg_dump -h jironbach.iobb.net -d eatlocaljapan_staging -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob('./bin/data/*.stg')
if bks.count > 10
  i = 0
  bks.reverse.each do |bk|
    i += 1
    if i > 10
      File.delete(bk)
    end
  end
end

