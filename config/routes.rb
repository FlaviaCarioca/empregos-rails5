Rails.application.routes.draw do
  namespace :api, path: '/', defaults: {format: 'json'} do
    namespace :v1 do
      post 'auth' => 'auth#authenticate' # login

      resources :users, only: [:create]

      put 'candidate' => 'candidates#update'
    end
  end
end
