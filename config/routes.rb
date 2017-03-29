Rails.application.routes.draw do
  root 'pages#home'

  # Api routes
  namespace :api do
    namespace :v1 do
      post 'projects/:client_id/events', to: "events#create"
    end
  end

  get 'feed/:id', to: "feed#index", as: 'feed'

  resources :projects
  resources :suggestions
  resources :events
  get 'events/configure/:id', to: "events#configure", as: 'event_configuration'

  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get 'start', to: "registrations#start", as: 'start'
    get 'signup', to: "registrations#new", as: 'signup'
    get 'login', to: "sessions#new", as: 'login'
    get 'settings', to: "registrations#edit", as: 'settings'
    delete 'logout', to: "sessions#destroy", as: 'logout'
  end

end
