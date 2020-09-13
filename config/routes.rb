Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/logout',                      to: 'sessions#destroy'

  get '/onboarding', to: 'onboarding#new'

  patch '/users/:id', to: 'users#update'
  get '/profile/edit', to: 'users#edit'

  get '/dashboard', to: 'dashboard#index'

  post '/log', to: 'log#new'
end
