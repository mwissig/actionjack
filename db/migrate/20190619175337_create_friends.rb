class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.boolean :accepted, :default => false

      t.timestamps
    end
  end
end
