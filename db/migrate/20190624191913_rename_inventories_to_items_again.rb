class RenameInventoriesToItemsAgain < ActiveRecord::Migration[5.2]
  def change
      rename_table :inventories, :items
  end
end
