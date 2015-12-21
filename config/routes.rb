Rails.application.routes.draw do
  
  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  root 'static_pages#home'

  resources :microposts
  resources :users
end
