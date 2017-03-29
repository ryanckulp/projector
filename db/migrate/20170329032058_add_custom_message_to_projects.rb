class AddCustomMessageToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :custom_message, :text
    remove_column :events, :custom_message
  end
end
