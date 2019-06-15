class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :email_confirmed, from: false, to: true)
  end
end
