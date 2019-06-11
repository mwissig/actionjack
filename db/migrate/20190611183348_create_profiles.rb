class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :color
      t.text :desc
      t.integer :user_id
      t.timestamps
    end
  end
end
