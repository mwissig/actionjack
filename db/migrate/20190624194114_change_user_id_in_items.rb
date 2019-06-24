class ChangeUserIdInItems < ActiveRecord::Migration[5.2]
  def change
            change_column :items, :user_id, :integer
  end
end
