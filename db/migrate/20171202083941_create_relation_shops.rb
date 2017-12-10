class CreateRelationShops < ActiveRecord::Migration
  def change
    create_table :relation_shops do |t|
      t.string :name
      t.string :shop_master_id
      t.string :shop_manager_id
      t.integer :not_used

      t.timestamps null: false
    end
    add_index  :relation_shops, [:shop_manager_id, :shop_master_id,], unique: true
  end
end
