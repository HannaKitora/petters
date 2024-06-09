Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  resources :pets, only: [:new, :index, :show, :edit, :destroy, :create, :update]

  devise_for :users
  root to: 'homes#top'
  
  # get 'pets/new'
  # get 'pets/index'
  # get 'pets/show'
  # get 'pets/edit'
  # get 'pets/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
