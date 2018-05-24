class AddColumnToDeviceConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :device_configs, :user_auth_token, :string
  end
end
