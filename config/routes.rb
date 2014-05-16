Eclist::Application.routes.draw do
  
  get "bienvenida/inicio"
  root to: 'bienvenida#inicio'
end
