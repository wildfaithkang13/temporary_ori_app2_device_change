# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#rake db:seedすれば以下のテストデータがテーブルにINSERTされる

#持株会社が複数存在するパターンがあるため配列にした方が良さそう。
#電話番号が一意
# AvailableCouponServiceShopMaster.create(subsidiary_company_name: 'ファミリーマート',
#                                         parent_company_name: '伊藤忠商事株式会社',
#                                         coupon_content: '',
#                                         business_category_code: 'Convenience',
#                                         company_mail_address: 'familymart@co.jp',
#                                         telephone_number: '0120-222-222',
#                                         shop_master_id: 'familymartlove',
#                                         available_service_start_date: '2016-12-31',
#                                         available_service_end_date: '2020-12-31'
#                                         )

CouponShopList.create(telephone_number: '0354569305',
                      shop_name: 'ファミリーマート　道玄坂上店',
                      shop_address: '東京都渋谷区円山町28-1',
                      shop_latitude: '35.656064',
                      shop_longtitude: '139.694724',
                      all_day_flag: true,
                      open_time: nil,
                      close_time: nil,
                      holiday: '[""]',
                      holiday_condition: nil,
                      shop_master_id: 'familymartlove',
                      occupation_code: 'retail',
                      branch_office_id: 'aEaRXeILaZsOhbxS2CvmIg',
                      subsidiary_company_name: 'ファミリーマート'
                      )

# available_shop1 = AvailableCouponServiceShopMaster.create(subsidiary_company_name: 'デニーズ',
#                                         parent_company_name: 'セブン&アイ・ホールディングス',
#                                         coupon_content: '',
#                                         business_category_code: 'Restaurant',
#                                         company_mail_address: 'sevenandi@co.jp',
#                                         telephone_number: '0120-111-111',
#                                         shop_master_id: 'thisissample1',
#                                         available_service_start_date: '2017-12-31',
#                                         available_service_end_date: '2018-12-31'
#                                         )

# 5.times do |n|
# sh = available_shop1.shop_managers.build(email: "test#{n}@co.jp",
#                             name: 'test',
#                             password: "qaz1wsx2#{n}",
#                             occupation: '学生',
#                             address: '東京都渋谷区',
#                             birthday: '2017-11-01',
#                             nationality: 'JPN',
#                             sex: 'man',
#                             status: '20')
#
# sh.save
#
# end
