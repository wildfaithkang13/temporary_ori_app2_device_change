class CreateShopManagers < ActiveRecord::Migration
  def change
    create_table :shop_managers do |t|
      t.string :shop_master_id, :null => false
      # t.references :available_coupon_service_shop_masters, foreign_key: true
      t.timestamps null: false
    end
    # binding.pry
    # add_foreign_key :shop_managers, :available_coupon_service_shop_masters, column: 'shop_master_id', on_delete: :cascade
  end
end
