ShopService.create(name: '予約可', name_en: 'Reservation')
ShopService.create(name: '個室あり', name_en: 'Private room')
ShopService.create(name: '出前・デリバリー可', name_en: 'Delivery')
ShopService.create(name: 'テイクアウト可', name_en: 'Take-out')
Prefecture.create(name: '北海道', name_en: 'Hokkaido')
Prefecture.create(name: '東京', name_en: 'Hokkaido')
Prefecture.create(name: '京都', name_en: 'Kyoto')
Prefecture.create(name: '大阪', name_en: 'Osaka')
Prefecture.create(name: '鹿児島', name_en: 'Kagoshima')
Prefecture.create(name: '沖縄', name_en: 'Okinawa')
Smoking.create(name: '完全禁煙', name_en: 'Non-Smoking')
Smoking.create(name: '分煙（エリアによる分煙）', name_en: 'Smoking in separated area')
Smoking.create(name: '完全分煙（部屋による分煙）', name_en: 'Smoking in separated room')
Smoking.create(name: '喫煙可', name_en: 'Smoking is permitted')
English.create(name: '英語メニューあり', name_en: 'English menu')
English.create(name: '英語できるスタッフいます', name_en: 'English speaking staff')
English.create(name: '日本語スタッフだけですが心より歓迎いたします', name_en: 'Japanese speaking staff only but we would be delighted to welcome all our guests!')
Listing.create(open: true, title: 'テスト1', title_en: 'test1')
Listing.create(open: true, title: 'テスト2', title_en: 'test2')
Listing.create(open: true, title: 'テスト3', title_en: 'test3')
Listing.create(open: true, title: 'テスト4', title_en: 'test4')
ShopCategory.create(id: 13, name: 'うどん・そば', name_en: 'Udon/Soba(Noodle)')
ShopCategory.create(id: 11, name: 'ラーメン・つけ麺', name_en: 'Ramen')
ShopCategory.create(id: 26, name: '洋菓子 和菓子・甘味処 スイーツ', name_en: 'Sweets/Desert')
ShopCategory.create(id: 10, name: '串揚げ', name_en: 'Kushigage')
ShopCategory.create(id: 14, name: 'その他和食', name_en: 'Other Japanese')
ShopCategory.create(id: 18, name: 'カレー', name_en: 'Curry')
