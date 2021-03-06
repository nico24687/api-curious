Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/:nickname', to: 'users#show', as: 'user'
  resources :repositories, only: [:new, :create]
  
end
