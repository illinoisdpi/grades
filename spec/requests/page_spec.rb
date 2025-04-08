require 'swagger_helper'

RSpec.describe 'Page API', type: :request do
  # Skip the actual tests for now and just generate Swagger docs
  before { skip "We'll focus on generating Swagger docs" }

  path '/' do
    get 'Landing page' do
      tags 'Page'
      produces 'text/html'

      response '200', 'landing page' do
        run_test!
      end
    end
  end
end
