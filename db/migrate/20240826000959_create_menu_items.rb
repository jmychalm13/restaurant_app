class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :category, default: 0, null: false
      t.boolean :availability

      t.timestamps
    end
  end
end
