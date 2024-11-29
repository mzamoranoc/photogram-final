class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :comments_count, :integer
    add_column :users, :likes_count, :integer
    add_column :users, :private, :boolean
    add_column :users, :photos_count, :integer
  end
end
