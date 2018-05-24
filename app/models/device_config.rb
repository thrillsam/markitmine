class DeviceConfig < ApplicationRecord

  validates :device_uuid, presence: :true
  belongs_to :user

  enum os: ["android", "ios"]
end
