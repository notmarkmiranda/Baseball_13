class CreateAccomplishments < ActiveRecord::Migration[5.1]
  def change
    create_table :accomplishments do |t|
      t.references :team, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
