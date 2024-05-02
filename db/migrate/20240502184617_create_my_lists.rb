class CreateMyLists < ActiveRecord::Migration[7.1]
  def change
    create_table :my_lists do |t|
      t.references :semi_user, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
