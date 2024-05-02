class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes do |t|
      t.integer :episode_no
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
