Rails.application.routes.draw do
  root 'welcome#index'

  get '/about', to: 'welcome#about'

  get '/profile', to: 'languages#index'

  get '/portuguese', to: 'portuguese#index'

  get '/portuguese/vocabulary', to: 'portuguese#vocabulary'

  get '/portuguese/words', to: 'portuguese#words'

  get '/portuguese/translate', to: 'portuguese#translate'

  post '/portuguese/translate', to: 'portuguese#translate'

  get '/register', to: 'users#register'

  post '/register', to: 'users#create'

  get '/profile/:id', to: 'languages#index'

  get '/login', to: 'users#login'

  post '/login', to: 'users#signin'

  get '/logout', to: 'users#logout'
end
