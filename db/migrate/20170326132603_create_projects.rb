class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :website
      t.string :product_hunt_url
      t.integer :product_hunt_votes
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
