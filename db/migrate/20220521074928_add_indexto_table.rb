class AddIndextoTable < ActiveRecord::Migration[7.0]
  def change
    add_index :followings, :following_id
    #Ex:- add_index("admin_users", "username")
    add_index :followers, :follower_id
    #Ex:- add_index("admin_users", "username")
  end
end
