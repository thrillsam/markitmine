class AddUserToCopyright < ActiveRecord::Migration[5.1]
  def change
    add_reference :copyrights, :user, foreign_key: true
  end
end
