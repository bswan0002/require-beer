Rails.application.routes.draw do
  root to: 'pages#home'

  get '/posts/sort_by_col', to: 'posts#sort_by_col', as: 'sort_by_col'
  get '/posts/filter_by_fparam', to: 'posts#filter_by_fparam', as: 'filter_by_fparam'

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
