Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  draw(:api)

  resources :resources
  get "/submissions/validate_token", to: "submissions#validate_token"
  get "/submissions/resource", to: "submissions#resource"
  resources :builds, only: [ :create ]

  # mount LtiProvider::Engine => "/"
  scope module: :lti_provider do
    # post "/submit_grade", to: "grades#submit_grade"
    post "/launch", to: "lti#launch"
    get "/configure", to: "lti#configure"
  end



  # Defines the root path route ("/")
  root "page#landing"
end
