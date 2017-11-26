class ChangeColumnToShopManagers < ActiveRecord::Migration
  # 変更内容
  def up
    change_column :shop_managers, :register_shop_count, :integer
  end

  # 変更前の状態
  def down
    change_column :shop_managers, :register_shop_count, :integer, null: false, default: 0
  end
end
