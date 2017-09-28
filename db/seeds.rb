# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


CouponShopList.create(telephone_number: '000000000',
                      shop_name: '渋谷のお店1',
                      shop_address: '東京都渋谷区道玄坂2-29-1',
                      shop_latitude: 35.659589,
                      shop_longtitude: 139.698629,
                      all_day_flag: true,
                      open_time: nil,
                      close_time: nil,
                      shop_management_id: SecureRandom.uuid,
                      occupation_code: 'retail',
                      holiday: '["Mon" "Tue"]',
                      holiday_condition: true
                      )
