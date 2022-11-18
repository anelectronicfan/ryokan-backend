Rails.application.routes.draw do
  get 'index/index'
  get 'list/list'
  root "index#index", as: 'index'
  resources :properties
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end