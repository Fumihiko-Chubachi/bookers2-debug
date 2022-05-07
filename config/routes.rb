Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    #与フォローアクション
    get 'followings' => 'relationships#followings', as: 'followings'
    #被フォローアクション
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end