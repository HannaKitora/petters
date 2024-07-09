Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :events, only: [:new, :index, :show, :edit, :destroy, :create, :update]
  end
  
  scope module: :public do
    devise_for :users
    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    
    resources :pets, only: [:new, :create, :index, :show, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :index, :edit, :update]
    resources :pets, only: [:new, :index, :show, :edit, :destroy, :create, :update]
    resources :events, only: [:index, :show]
    # get 'entries/confirm'
    post '/entries/thanks', to: 'public/entries#thanks'
    # get 'entries/thanks'
    resources :entries, only: [:create, :index, :destroy, :update, :show]
  end
  get "/search" => "searches#search"
end
