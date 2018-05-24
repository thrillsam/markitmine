class AddDateToCopyright < ActiveRecord::Migration[5.1]
  def change
    add_column :copyrights, :date, :datetime
  end
end
