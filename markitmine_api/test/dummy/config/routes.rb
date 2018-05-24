Rails.application.routes.draw do
  mount MarkitmineApi::Engine => "/markitmine_api"
end
