class AddEmployeeStatusToShopManagers < ActiveRecord::Migration
  def change
    add_column :shop_managers, :employee_status, :integer
  end
end
