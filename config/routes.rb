Eclist::Application.routes.draw do
  resources :fiestas do
    resources :convidados
  end
  resources :listas do
    resources :regalos do
      get '/reservar' => 'compromisos#reservar', as: :reservar
      get '/comprar' => 'compromisos#comprar', as: :comprar
      get '/liberar' => 'compromisos#liberar', as: :liberar
      resources :compromisos, only: [:destroy]
    end
  end
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
  get "ingresar", to: "devise/sessions#new"
  get "registrarse", to: "devise/registrations#new"
  end
  resources :users, only: [:update]
  get "inicio" => "bienvenida#inicio"
  root to: 'bienvenida#inicio'

end
