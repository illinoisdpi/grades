Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :resources
  get "/submissions/validate_token", to: "submissions#validate_token"
  get "/submissions/resource", to: "submissions#resource"
  resources :builds, only: [ :create, :show ]

  scope module: :lti_provider do
    post "/launch", to: "lti#launch", as: :lti_launch
    get "/config", to: "lti#configuration", as: :lti_config
  end

  root "page#landing"
end
