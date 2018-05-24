class AddSourceToCopyright < ActiveRecord::Migration[5.1]
  def change
    add_column :copyrights,  :source,        :string
    add_column :copyrights,  :uploaded_date, :datetime
    add_column :copyrights,  :uploaded_id,   :string
    add_column :copyrights,  :likes_count,   :integer
    add_column :copyrights,  :tags,          :string, as: :array
  end
end
