Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'

  get '/onboarding', to: 'onboarding#new'

  patch '/users/:id', to: 'users#update'

  get '/dashboard', to: 'dashboard#show'
end
