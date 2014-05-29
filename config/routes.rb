Eclist::Application.routes.draw do
  resources :tiendas
  get '/invitaciones' => 'fiestas#invitaciones'
  get '/regalos_reservados' => 'regalos#reservados'
  resources :fiestas do
    resources :convidados do
     get '/confirmar' => 'convidados#confirmar', as: :confirmar
     get '/declinar' => 'convidados#declinar', as: :declinar
    end
    resources :listas do
      resources :regalos do
        collection { post :ordenar }
        get '/reservar' => 'compromisos#reservar', as: :reservar
        get '/comprar' => 'compromisos#comprar', as: :comprar
        get '/liberar' => 'compromisos#liberar', as: :liberar
        resources :compromisos, only: [:destroy]
      end
    end
  end
  
  devise_for :users, controllers: { registrations: 'registrations' , :omniauth_callbacks => "omniauth_callbacks"}
  devise_scope :user do
  get "ingresar", to: "devise/sessions#new"
  get "registrarse", to: "devise/registrations#new"
  end
  get "inicio" => "bienvenida#inicio"
  # Change root path if user is authenticated
  authenticated :user do
    root to: "fiestas#index", :as => "authenticated_root"
  end
  root to: 'bienvenida#inicio'
end
