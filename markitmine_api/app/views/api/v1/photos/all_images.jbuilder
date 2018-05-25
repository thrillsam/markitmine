json.copyrights @copyrights do |copyright|
  json.id copyright.id
  json.name copyright.name.to_s
  json.image copyright.image
  json.image_file_name copyright.image_file_name
  json.image_content_type copyright.image_content_type
  json.image_file_size copyright.image_file_size
  json.image_updated_at copyright.image_updated_at
  json.date copyright.uploaded_date
  json.type_of_file copyright.type_of_file
  json.user_id copyright.user_id
end