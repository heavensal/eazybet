class AddRefFromUrlToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :ref_from_url, :string
  end
end
