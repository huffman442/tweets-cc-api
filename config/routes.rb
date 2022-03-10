Rails.application.routes.draw do
  get 'tweets/show/:topic', to: 'tweets#show'
  get 'tweets/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
