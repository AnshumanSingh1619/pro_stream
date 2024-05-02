class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.string :name
      t.string :movie_type
      t.boolean :available_for_kids
      t.string :actor
      t.text :description
      t.string :director
      t.string :languages, array: true, default: []
      t.string :type_of_content, array: true, default: []

      t.timestamps
    end
  end
end
