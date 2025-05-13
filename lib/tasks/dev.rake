unless Rails.env.production?
  namespace :dev do
    desc "Hydrate the database with sample data"
    task prime: :environment do
      # TODO: resources
      # TODO: lti_provider_launches
      # TODO: lti_provider_users
    end

    desc "Destroy, re-create, re-seed, and re-prime the database"
    task reprime: [
      :environment,
      "db:drop",
      "db:create",
      "db:migrate",
      "db:seed",
      "dev:prime"
    ]
  end
end
