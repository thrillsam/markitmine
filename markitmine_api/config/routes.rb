Rails.application.routes.draw do
  post "/api/v1/sessions/sign_up" => "api/v1/sessions#sign_up"
  post "/api/v1/sessions/sign_in" => "api/v1/sessions#sign_in"
  post "/api/v1/sessions/forgot_password" => "api/v1/sessions#forgot_password"
  post "/api/v1/sessions/reset_password" => "api/v1/sessions#reset_password"
  post "/api/v1/sessions/destroy" => "api/v1/sessions#destroy"
  post "api/v1/photos/upload_image" => "api/v1/photos#upload_image"
  post "api/v1/photos/all_images" => "api/v1/photos#all_images"
  namespace :api do
	 	namespace :v1 do
      get '/instagram_api', to: "photos#instagram"
      get '/instagram_api', to: "photos#facebook"
    end
  end
end
