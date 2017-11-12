class AvailableCouponServiceShopMasters < ActiveRecord::Migration
  def change
      # create_table :available_coupon_service_shop_masters, id: false do |t|
       create_table :available_coupon_service_shop_masters do |t|
        t.string :subsidiary_company_name
        t.string :parent_company_name
        t.string :coupon_content
        t.string :business_category_code
        t.string :company_mail_address
        t.string :telephone_number
        t.string :shop_master_id, :null => false
        t.timestamps null: false
      end
      # execute "ALTER TABLE available_coupon_service_shop_masters ADD PRIMARY KEY (shop_master_id)"
  end
end
