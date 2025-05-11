class AddPictureToTeams < ActiveRecord::Migration[8.0]
  def change
    add_column :teams, :picture, :string
  end
end
