#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

backup_to = "data/#{Time.now.strftime("%j%H%M")}.dev"
`pg_dump -h jironbach.iobb.net -d eatlocaljapan_development -U eatlocaljapan -f #{backup_to}`

