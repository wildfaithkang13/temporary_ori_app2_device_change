# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#rake db:seedすれば以下のテストデータがテーブルにINSERTされる

available = AvailableCouponServiceShopMaster.create(subsidiary_company_name: 'デニーズ',
                                        parent_company_name: 'セブン&アイ・ホールディングス',
                                        coupon_content: '',
                                        business_category_code: 'Restaurant',
                                        company_mail_address: 'sevenandi@co.jp',
                                        telephone_number: '0120-111-111',
                                        shop_master_id: 'thisissample1',
                                        available_service_start_date: '2017-12-31',
                                        available_service_end_date: '2018-12-31'
                                        )
5.times do |n|
sh = available.shop_managers.build(email: "test#{n}@co.jp",
                            name: 'test',
                            password: "qaz1wsx2#{n}",
                            occupation: '学生',
                            address: '東京都渋谷区',
                            birthday: '2017-11-01',
                            nationality: 'JPN',
                            sex: 'man',
                            status: '20')


sh.save
end
