#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

path = '/home/eatlocaljapan/backup'
backup_to = "#{path}/#{Time.now.strftime("%j%H%M%S")}.prd"
puts backup_to
`/usr/bin/pg_dump -h www.eatlocaljapan.com -d eatlocaljapan -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob("#{path}/*.prd")
if bks.count > 12
  i = 0
  bks.sort.reverse.each do |bk|
    i += 1
    if i > 10
      File.delete(bk)
    end
  end
end

`rm -f /tmp/backup.tgz`
`cd`
`tar cvf /tmp/backup.tgz backup`

