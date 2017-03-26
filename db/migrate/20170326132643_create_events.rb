class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.json :variables
      t.references :project, foreign_key: true
      t.timestamps null: false
    end
  end
end
