class AddCustomMessageToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :custom_message, :text
  end
end
