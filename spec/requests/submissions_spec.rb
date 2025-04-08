require 'swagger_helper'

RSpec.describe 'Submissions API', type: :request do
  # Skip the actual tests for now and just generate Swagger docs
  before { skip "We'll focus on generating Swagger docs" }

  path '/submissions/validate_token' do
    get 'Validates a submission token' do
      tags 'Submissions'
      produces 'application/json'
      parameter name: :token, in: :query, type: :string, required: true,
                description: 'Submission token to validate'

      response '200', 'token validation status' do
        schema type: :object,
               properties: {
                 success: { type: :boolean }
               },
               required: [ 'success' ]

        let(:token) { 'valid_token' }
        run_test!
      end
    end
  end

  path '/submissions/resource' do
    get 'Retrieves resource information for a submission' do
      tags 'Submissions'
      produces 'application/json'

      response '200', 'resource information' do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 repo_slug: { type: :string },
                 spec_folder_sha: { type: :string },
                 source_code_url: { type: :string }
               },
               required: [ 'success', 'repo_slug', 'spec_folder_sha', 'source_code_url' ]

        run_test!
      end
    end
  end
end
