namespace :ngevent do
  desc 'close ngevents'
  task close: :environment do
    ngs = UserNgevent.where( active: true ).where(UserNgevent.arel_table[:end].lt Time.zone.now.yesterday.end_of_day )
    ngs.update_all(active: false)
  end
end
