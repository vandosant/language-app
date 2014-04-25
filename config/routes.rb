Rails.application.routes.draw do
  root 'welcome#index'

  get '/about', to: 'welcome#about'

  get '/profile', to: 'languages#index'

  get '/portuguese', to: 'portuguese#index'

  get '/portuguese/vocabulary', to: 'portuguese#vocabulary'
end
