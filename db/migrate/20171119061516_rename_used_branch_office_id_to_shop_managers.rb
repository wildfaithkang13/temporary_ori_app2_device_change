class RenameUsedBranchOfficeIdToShopManagers < ActiveRecord::Migration
  def change
    rename_column :coupon_shop_lists, :shop_management_id, :shop_master_id
    add_column :coupon_shop_lists, :branch_office_id, :string
  end
end
