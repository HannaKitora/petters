Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
  scope module: :public do
    devise_for :users
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
    resources :events, only: [:new, :index, :show, :edit, :destroy, :create, :update]
    resources :entries, only: [:new, :confirm, :thanks, :create, :index, :show]
    get 'entries/confirm'
    get 'entries/thanks'
  end
  

  
  # devise_for :admins
  # get 'entries/new'
  # get 'entries/create'
  # get 'entries/index'
  # get 'entries/show'
  # get 'events/new'
  # get 'events/index'
  # get 'events/edit'
  # get 'events/destroy'
  # get 'events/show'
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'pets/new'
  # get 'pets/index'
  # get 'pets/show'
  # get 'pets/edit'
  # get 'pets/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
