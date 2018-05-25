Rails.application.routes.draw do

  get 'home/index'
  get '/get_access_token',    to: "copyrights#get_access_token"
  get '/instagram_api',       to: "copyrights#instagram_api"
  get '/transaction_details',  to: "copyrights#transaction_details"
  post '/add_transaction',     to: "copyrights#add_transaction"
  get '/pending_transactions', to: "copyrights#pending_transactions"
  devise_for :users
  resources :copyrights
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
