class ChangeShopitemsDatatype < ActiveRecord::Migration[5.2]
  def change
    change_column :shopitems, :shop_price, :integer
    change_column :shopitems, :sellback_price, :integer
  end
end
