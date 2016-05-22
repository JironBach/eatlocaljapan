#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

if Dir.pwd[-3..-1] == 'bin'
  puts 'アプリケーションのrootディレクトリで実行してください。'
  return
end

if ARGV[0].nil?
  puts '復元データを選択してください。'
  return
end

`psql -h jironbach.iobb.net -U eatlocaljapan -d eatlocaljapan_staging < #{ARGV[0]}`

