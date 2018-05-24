class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :contact_number, :string
    add_column :users, :password, :string
  end
end
