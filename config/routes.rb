Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  resources :copyrights
  get '/instagram_api', to: "copyrights#instagram_api"
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
