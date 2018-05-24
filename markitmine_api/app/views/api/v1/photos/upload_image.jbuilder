json.copyright do
  json.id @copyright.id
  json.name @copyright.name.to_s
  json.image @copyright.image
  json.image_file_name @copyright.image_file_name
  json.image_content_type @copyright.image_content_type
  json.image_file_size @copyright.image_file_size
  json.image_updated_at @copyright.image_updated_at
  json.date @copyright.date
  json.type @copyright.type
end