Eclist::Application.routes.draw do
  devise_scope :user do
  get "ingresar", to: "devise/sessions#new"
  get "registrarse", to: "devise/registrations#new"
  end
  devise_for :users
  get "inicio" => "bienvenida#inicio"
  root to: 'bienvenida#inicio'

end
