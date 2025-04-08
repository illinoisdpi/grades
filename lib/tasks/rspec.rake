if defined?(RSpec)
  namespace :spec do
    desc "Run RSpec tests and generate Swagger docs"
    task all: [ :spec, "rswag:specs:swaggerize" ]
  end
end
