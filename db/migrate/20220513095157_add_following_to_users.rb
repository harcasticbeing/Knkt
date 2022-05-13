class AddFollowingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :following, :integer, array: true, default: []
  end
end
