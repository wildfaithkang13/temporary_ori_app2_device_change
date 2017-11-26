class AddSubsidiaryCompanyNameToCouponShopLists < ActiveRecord::Migration
  def change
    add_column :coupon_shop_lists, :subsidiary_company_name, :string
  end
end
