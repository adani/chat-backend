Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      post '/sessions', to: 'session#login'
      delete '/sessions', to: 'session#logout'
      get '/sessions', to: 'session#refresh'
      post '/users', to: 'user#create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
