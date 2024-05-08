class AddColumnToContent < ActiveRecord::Migration[7.1]
  def change
    add_column :contents, :trailer, :string
    add_column :contents, :movie, :string
    add_column :contents, :poster, :string
    add_column :episodes, :episode, :string
    add_column :semi_users, :profile_pic, :string
  end
end
