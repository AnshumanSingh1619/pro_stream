class AddColumnToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :firstname, :string
    add_column :admins, :lastname, :string
    add_column :admins, :gender, :string
    add_column :admins, :age, :integer
    add_column :admins, :date_of_birth, :date
    add_column :admins, :jti, :string, null: false
    add_index :admins, :jti, unique: true
  end
end
