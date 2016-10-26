namespace :sample_listings do
  desc 'insert sample listing data'
  task insert: :environment do
    spots = [
      {user_id: 2, title: '清水寺', location: '京都府京都市東山区清水1-294', latitude: 34.994401, longitude: 135.783283},
      {user_id: 2, title: '京都御所', location: '京都府京都市上京区京都御苑3', latitude: 35.025414, longitude: 135.762125},
      {user_id: 2, title: '八坂神社', location: '京都府京都市東山区祇園町北側625', latitude: 35.003634, longitude: 135.778525},
      {user_id: 2, title: '金閣寺', location: '京都府京都市北区金閣寺町1', latitude: 35.039381, longitude: 135.729230},
      {user_id: 2, title: '北野天満宮', location: '京都府京都市上京区北野馬喰町', latitude: 35.030428, longitude: 135.735327},
      {user_id: 2, title: '清水寺', location: '神奈川県海老名市国分北2丁目', latitude: 35.460435, longitude: 139.398696},
      {user_id: 2, title: '清水寺', location: '群馬県高崎市石原町2401', latitude: 36.309917, longitude: 138.989039},
      {user_id: 2, title: '清水寺', location: '岐阜県加茂郡富加町加治田985', latitude: 35.498399, longitude: 136.997405},
      {user_id: 2, title: '清水寺', location: '愛知県東海市荒尾町西川60', latitude: 35.028889, longitude: 136.911644}
    ]

    spots.each do |spot|
      Listing.find_or_create_by!(spot)
    end
    Listing.import(force: true)
  end
end
