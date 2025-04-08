namespace :rswag do
  namespace :specs do
    desc "Generate Swagger JSON files from integration specs"
    task :swaggerize do
      require "rspec/core/rake_task"

      RSpec::Core::RakeTask.new("swaggerize") do |t|
        t.pattern = "spec/requests/**/*_spec.rb"
        t.rspec_opts = [ "--format Rswag::Specs::SwaggerFormatter", "--order defined" ]
      end

      Rake::Task["swaggerize"].invoke
    end
  end
end
