class CreateDeviceConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :device_configs do |t|
      t.integer :os
      t.string :device_type
      t.string :device_uuid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
