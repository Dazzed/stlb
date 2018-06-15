class AddQuantityToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :quantity, :integer, default: 1
  end
end
