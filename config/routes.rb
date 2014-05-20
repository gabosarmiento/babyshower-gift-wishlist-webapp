Eclist::Application.routes.draw do
  resources :fiestas do
    resources :convidados
    resources :listas do
      resources :regalos do
        get '/reservar' => 'compromisos#reservar', as: :reservar
        get '/comprar' => 'compromisos#comprar', as: :comprar
        get '/liberar' => 'compromisos#liberar', as: :liberar
        resources :compromisos, only: [:destroy]
      end
    end
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
  get "ingresar", to: "devise/sessions#new"
  get "registrarse", to: "devise/registrations#new"
  end
  resources :users, only: [:update]
  get "inicio" => "bienvenida#inicio"
  # Change root path if user is authenticated
  authenticated :user do
    root to: "fiestas#index", :as => "authenticated_root"
  end
  root to: 'bienvenida#inicio'
end
