Rails.application.routes.draw do
  devise_for :users
  resources :copyrights
  root to: "copyrights#index"
  get '/instagram_api', to: "copyrights#instagram_api"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
