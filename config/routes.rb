Eclist::Application.routes.draw do
  resources :listas do
    resources :regalos 
  end
  devise_scope :user do
  get "ingresar", to: "devise/sessions#new"
  get "registrarse", to: "devise/registrations#new"
  end
  devise_for :users
  resources :users, only: [:update]
  get "inicio" => "bienvenida#inicio"
  root to: 'bienvenida#inicio'

end
