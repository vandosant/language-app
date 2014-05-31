Rails.application.routes.draw do
  root 'welcome#index'

  get '/about', to: 'welcome#about'

  get '/languages', to: 'languages#index'

  get '/portuguese', to: 'portuguese#index'

  get '/portuguese/vocabulary', to: 'portuguese#vocabulary'

  get '/portuguese/words', to: 'portuguese#words'

  get '/portuguese/translate', to: 'portuguese#translate'

  post '/portuguese/translate', to: 'portuguese#translate'

  get '/register', to: 'users#register'

  post '/register', to: 'users#create'

  get '/profile/:id', to: 'languages#index'

  resource :sessions

  get '/login', to: 'sessions#new', as: :login

  get '/logout', to: 'sessions#destroy', as: :logout
end
