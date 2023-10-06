class AddPriceToHouses < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :price, :decimal
  end
end
