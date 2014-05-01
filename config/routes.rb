Rails.application.routes.draw do
  root 'welcome#index'

  get '/about', to: 'welcome#about'

  get '/profile', to: 'languages#index'

  get '/portuguese', to: 'portuguese#index'

  get '/portuguese/vocabulary', to: 'portuguese#vocabulary'

  get '/register', to: 'users#register'

  post '/profile', to: 'users#new'

  get '/profile/:id', to: 'languages#index'

  get '/login', to: 'users#login'
end
