class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :hometown, :string
    add_column :users, :gender, :string
    add_column :users, :bio, :text
    add_column :users, :image_url, :string
  end
end
