class AddColumnTouserForStipe < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :subscription_status, :string
    add_column :users, :subscription_ends_at, :datetime
    add_column :users, :plan, :string
  end
end
