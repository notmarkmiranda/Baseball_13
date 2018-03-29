class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :person, foreign_key: true
      t.string :mlb_id

      t.timestamps
    end
  end
end
