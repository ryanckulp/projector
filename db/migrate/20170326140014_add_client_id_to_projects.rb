class AddClientIdToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :client_id, :string
  end
end
