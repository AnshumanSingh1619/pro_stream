class ChangeBooleanToStringInContents < ActiveRecord::Migration[6.0]
  def change
    change_column :contents, :available_for_kids, :string
  end
end
