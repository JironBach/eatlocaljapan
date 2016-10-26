#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

path = '/home/eatlocaljapan/backup'
# rubocop:disable Rails/TimeZone
backup_to = "#{path}/#{Time.now.strftime('%j%H%M%S')}.prd"
# rubocop:enable Rails/TimeZone
puts backup_to
`/usr/bin/pg_dump -h www.eatlocaljapan.com -d eatlocaljapan -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob("#{path}/*.prd")
if bks.count > 12
  i = 0
  bks.sort.reverse_each do |bk|
    i += 1
    i > 10 && File.delete(bk)
  end
end

`rm -f /tmp/backup.tgz`
`cd`
`tar cvf /tmp/backup.tgz backup`

