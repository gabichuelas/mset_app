Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'

  get '/onboarding', to: 'onboarding#new'

  patch '/users/:id', to: 'users#update'

  get '/dashboard', to: 'dashboard#index'

  get '/medications/new', to: 'medications#new'
  get '/medications', to: 'medications#index'
end
