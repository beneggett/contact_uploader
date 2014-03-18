class CreateUserLinkedAccounts < ActiveRecord::Migration
  def up
    create_table :user_linked_accounts do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user

      t.timestamps
    end
    add_index :user_linked_accounts, :user_id

    remove_column :users, :provider
    remove_column :users, :uid
  end

  def down
    drop_table :user_linked_accounts
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end

end
