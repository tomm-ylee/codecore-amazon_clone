# rails g migration change_price_type_in_product

class ChangePriceTypeInProduct < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :price, :float
  end
end

# rails db:migrate
