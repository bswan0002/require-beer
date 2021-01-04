Rails.application.routes.draw do
  root to: 'pages#home'

  resources :projects
  resources :posts do
    resources :comments
  end 

  put '/post/:id/like', to: 'posts#like', as: 'like'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
