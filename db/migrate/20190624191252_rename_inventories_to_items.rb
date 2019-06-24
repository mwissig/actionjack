class RenameInventoriesToItems < ActiveRecord::Migration[5.2]
  def change
    def self.up
  rename_table :inventories, :items
end

def self.down
  rename_table :inventories, :items
end
  end
end
