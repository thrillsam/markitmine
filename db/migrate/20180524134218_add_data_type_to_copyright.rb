class AddDataTypeToCopyright < ActiveRecord::Migration[5.1]
  def change
    add_column :copyrights, :type, :string
  end
end
