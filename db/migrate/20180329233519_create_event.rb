class CreateEvent < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.timestamp :timestamp
    end
  end
end
