class RemoveColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :contents, :trailer, :string
    remove_column :contents, :movie, :string
    remove_column :contents, :poster, :string
    remove_column :episodes, :episode, :string
    remove_column :semi_users, :profile_pic, :string
  end
end
