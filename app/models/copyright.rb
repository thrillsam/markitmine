class Copyright < ApplicationRecord
has_attached_file :image, styles: {medium: "600x600>", thumb: "300x300>"}
validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
belongs_to :user
has_one :instagram_user
end
