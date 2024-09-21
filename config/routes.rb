Rails.application.routes.draw do
  resource :map, only: [:show]
  get 'calendar' => 'calendar#index'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :kinds
    resources :users, only: [:destroy]
    resources :events, only: [:new, :index, :show, :edit, :destroy, :create, :update]
    resources :entries, only: [:index, :destroy]
    resources :orders, only: [:index]
  end
  
  scope module: :public do
    devise_for :users
    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe' #退会確認画面
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal' #論理削除
    get "/homes/goodbye" => "homes#goodbye", as: "goodbye"
    
    resources :pets, only: [:new, :create, :index, :show, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :index, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings',as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :pets, only: [:new, :index, :show, :edit, :destroy, :create, :update]
    resources :events, only: [:index, :show]
    get '/events/index', to: 'events#index', defaults: { format: 'json' }
    # get 'entries/confirm'
    post '/entries/thanks', to: 'public/entries#thanks'
    # get 'entries/thanks'
    resources :entries, only: [:create, :index, :destroy, :update, :show]
    resources :orders, only: [:new, :create, :confirm]
    get '/orders/confirm' => 'orders#confirm'
  end
  resources :notifications, only: [:update]
  get "/search" => "searches#search"
end
