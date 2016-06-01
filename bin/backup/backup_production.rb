#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#path = '/home/eatlocaljapan/www/production/eatlocaljapan/current'
backup_to = "/home/eatlocaljapan/backup/#{Time.now.strftime("%j%H%M%S")}.prd"
`/usr/bin/pg_dump -h www.eatlocaljapan.com -d eatlocaljapan -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob("#{backup_to}")
if bks.count > 10
  i = 0
  bks.reverse.each do |bk|
    i += 1
    if i > 10
      File.delete(bk)
    end
  end
end
