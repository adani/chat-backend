Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      post '/sessions', to: 'session#login'
      delete '/sessions/*id', to: 'session#logout', format: false
      post '/users', to: 'user#create'
      get '/chatroom/:id/online_users', to: 'chatroom#get_online_users'
    end
  end

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
