Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/logout',                      to: 'sessions#destroy'

  get '/onboarding', to: 'onboarding#new'

  patch '/users/:id', to: 'users#update'
  get '/profile/edit', to: 'users#edit'

  get '/dashboard', to: 'dashboard#index'

  get '/medications/new', to: 'medications#new'
  get '/medications/search', to: 'medications#search'
  get '/medications', to: 'medications#index'
  post '/medications/create', to: 'medications#create'
  get '/medications/edit', to: 'medications#edit'
  delete '/medications/delete', to: 'medications#destroy'
  get '/medications/:id', to: 'medications#show'

  post '/logs', to: 'logs#create'
  get '/logs', to: 'logs#index'

  get '/symptoms/search', to: 'symptoms#search'
end
