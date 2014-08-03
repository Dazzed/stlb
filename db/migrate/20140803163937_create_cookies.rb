class CreateCookies < ActiveRecord::Migration
  def change
    create_table :cookies do |t|
      t.references :oven, index: true
      t.string :fillings

      t.timestamps
    end
  end
end
