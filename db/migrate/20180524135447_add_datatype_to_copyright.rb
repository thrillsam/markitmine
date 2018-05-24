class AddDatatypeToCopyright < ActiveRecord::Migration[5.1]
  def change
    add_column :copyrights, :type_of_file, :string
  end
end
