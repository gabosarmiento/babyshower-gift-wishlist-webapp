Eclist::Application.routes.draw do
  
  devise_for :users
  get "bienvenida/inicio"
  root to: 'bienvenida#inicio'
end
