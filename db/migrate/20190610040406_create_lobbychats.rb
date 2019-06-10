class CreateLobbychats < ActiveRecord::Migration[5.2]
  def change
    create_table :lobbychats do |t|
      t.integer :user_id
      t.string :body
      t.string :link

      t.timestamps
    end
  end
end
