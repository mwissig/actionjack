class CreateShopitems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopitems do |t|
      t.string :name
      t.string :category
      t.integer :shop_price
      t.integer :sellback_price
      t.string :color
      t.string :material
      t.string :quality
      t.text :description
      t.text :long_description
      t.string :string1
      t.string :string2
      t.integer :integer1
      t.integer :integer2
      t.datetime :datetime1
      t.datetime :datetime2

      t.timestamps
    end
  end
end
