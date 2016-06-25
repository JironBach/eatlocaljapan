#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

path = '/Users/js/backup'
backup_to = "#{path}/#{Time.now.strftime("%j%H%M%S")}.stg"
puts backup_to
`/usr/local/bin/pg_dump -h jironbach.iobb.net -d eatlocaljapan_staging -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob("#{path}/*.stg")
if bks.count > 12
  i = 0
  bks.sort.reverse.each do |bk|
    i += 1
    if i > 12
      File.delete(bk)
    end
  end
end

