class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.text :message
      t.string :email_address
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
