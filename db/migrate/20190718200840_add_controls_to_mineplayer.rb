class AddControlsToMineplayer < ActiveRecord::Migration[5.2]
  def change
        add_column :mineplayers, :controls, :string
  end
end
