class CreateShopManagers < ActiveRecord::Migration
  def change
    create_table :shop_managers do |t|

      t.timestamps null: false
    end
  end
end
