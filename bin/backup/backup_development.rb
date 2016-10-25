#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

path = '/Users/js/backup'
# rubocop:disable Rails/TimeZone
backup_to = "#{path}/#{Time.now.strftime('%j%H%M%S')}.dev"
# rubocop:enable Rails/TimeZone
puts backup_to
`/usr/local/bin/pg_dump -h jironbach.iobb.net -d eatlocaljapan_development -U eatlocaljapan -f #{backup_to}`

bks = Dir.glob("#{path}/*.dev")
if bks.count > 12
  i = 0
  bks.sort.reverse_each do |bk|
    i += 1
    i > 12 && File.delete(bk)
  end
end

