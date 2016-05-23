#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

if ARGV[0].nil?
  puts '復元データを選択してください。'
  return
end

`psql -h jironbach.iobb.net -U eatlocaljapan -d eatlocaljapan_development < #{ARGV[0]}`

