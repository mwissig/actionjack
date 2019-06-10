class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :time_zone
      t.boolean :email_confirmed, :default => false
      t.string :confirm_token
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.boolean :admin, :default => false
      t.boolean :banned_from_chat, :default => false
      t.datetime :ban_until
      t.integer :points, :default => 1000
      t.integer :wins, :default => 0
      t.integer :losses, :default => 0
      t.datetime :time_since_daily_bonus, :default => DateTime.now
      t.string :color, :default => '#000000'

      t.timestamps
    end
        add_index :users, :email, unique: true
  end
end
