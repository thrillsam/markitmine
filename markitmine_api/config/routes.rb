Rails.application.routes.draw do
  namespace :api do
	 	namespace :v1 do
      get '/instagram_api', to: "photos#instagram"
      get '/instagram_api', to: "photos#facebook"
    end
  end
end
