class AddImageStringToCopyright < ActiveRecord::Migration[5.1]
  def change
    add_column :copyrights, :photo_url, :string
  end
end
