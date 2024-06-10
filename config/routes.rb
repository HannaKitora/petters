Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :pets, only: [:new, :index, :show, :edit, :destroy, :create, :update]
  resources :events, only: [:new, :index, :show, :edit, :destroy, :create, :update]


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
