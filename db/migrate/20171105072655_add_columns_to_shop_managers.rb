class AddColumnsToShopManagers < ActiveRecord::Migration
  def change
    add_column :shop_managers, :occupation, :string
    add_column :shop_managers, :address, :string
    add_column :shop_managers, :birthday, :string
    add_column :shop_managers, :nationality, :string
    add_column :shop_managers, :sex, :string
    # add_column :shop_managers, :shop_master_id, :string, :null => false
    add_column :shop_managers, :branch_office_id, :string
    add_column :shop_managers, :status, :string, limit: 2
    add_column :shop_managers, :used_branch_office_id, :string
    # add_foreign_key :shop_managers, :available_coupon_service_shop_masters, column: 'shop_master_id', on_delete: :cascade
  end
end
