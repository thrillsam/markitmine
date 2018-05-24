class CreateInstagramUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :instagram_users do |t|
      t.integer :user_id
      t.string :access_key

      t.timestamps
    end
  end
end
