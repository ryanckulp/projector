class AddAvatarUrlToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :avatar_url, :text
  end
end
