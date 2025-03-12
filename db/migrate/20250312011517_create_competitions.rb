class CreateCompetitions < ActiveRecord::Migration[8.0]
  def change
    create_table :competitions do |t|
      t.string :key
      t.string :group
      t.string :title
      t.string :description
      t.boolean :active
      t.boolean :has_outrights

      t.timestamps
    end
  end
end
