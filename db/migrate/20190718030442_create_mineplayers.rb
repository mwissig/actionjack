class CreateMineplayers < ActiveRecord::Migration[5.2]
  def change
    create_table :mineplayers do |t|
      t.integer :user_id
      t.integer :deltax
      t.integer :deltay
      t.string :coords
      t.string :pickaxe
      t.integer :axelvl
      t.integer :speed

      t.timestamps
    end
  end
end
