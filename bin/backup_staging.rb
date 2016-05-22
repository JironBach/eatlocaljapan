#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

path = '/Users/js/work/eatlocaljapan'
backup_to = "#{path}/bin/data/#{Time.now.strftime("%j%H%M%S")}.stg"
puts backup_to
`/usr/local/bin/pg_dump -h jironbach.iobb.net -d eatlocaljapan_staging -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob("#{path}/bin/data/*.stg")
if bks.count > 10
  i = 0
  bks.reverse.each do |bk|
    i += 1
    if i > 10
      File.delete(bk)
    end
  end
end

