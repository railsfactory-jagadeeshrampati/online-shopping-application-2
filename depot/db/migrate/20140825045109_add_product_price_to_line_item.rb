class AddProductPriceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :price, :decimal
  end
end
