class AddHiddenToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :hidden, :boolean, default: false
  end
end
