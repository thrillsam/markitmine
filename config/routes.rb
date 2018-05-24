Rails.application.routes.draw do
  resources :copyrights
  get '/instagram_api', to: "copyrights#instagram_api"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
