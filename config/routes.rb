Rails.application.routes.draw do
  root to: 'pages#home'

  resources :devs, only: [:index, :show]
  resources :projects
  resources :posts do
    resources :comments
  end

  put '/post/:id/like', to: 'posts#like', as: 'like'
  delete '/post/:id/unlike', to: 'posts#unlike', as: 'unlike'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
