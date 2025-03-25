namespace :api do
  resources :grades, only: [ :create ]
end
