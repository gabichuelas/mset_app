Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/logout',                      to: 'sessions#destroy'

  get '/onboarding', to: 'onboarding#new'

  patch '/users/:id', to: 'users#update'

  get '/dashboard', to: 'dashboard#index'

  get '/medications/new', to: 'medications#new'
  get '/medications/search', to: 'medications#search'
  get '/medications', to: 'medications#index'
  post '/medications/create', to: 'medications#create'
  post '/log', to: 'log#new'
end
