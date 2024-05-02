class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :jti, :string, null: false
    add_column :users, :date_of_birth, :date
    add_index :users, :jti, unique: true
    add_column :users, :devise_type, :string
  end
end
