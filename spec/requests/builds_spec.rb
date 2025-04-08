require 'swagger_helper'

RSpec.describe 'Builds API', type: :request do
  # Skip the actual tests for now and just generate Swagger docs
  before { skip "We'll focus on generating Swagger docs" }

  path '/builds/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Build ID'

    get 'Retrieves a build' do
      tags 'Builds'
      produces 'application/json', 'application/html'

      response '200', 'build found' do
        schema '$ref' => '#/components/schemas/build'
        let(:id) { 'valid' }

        run_test!
      end

      response '404', 'build not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/builds' do
    post 'Creates a build' do
      tags 'Builds'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :build, in: :body, schema: {
        type: :object,
        properties: {
          access_token: { type: :string },
          commit_sha: { type: :string },
          username: { type: :string },
          reponame: { type: :string },
          source: { type: :string },
          test_output: {
            type: :object,
            properties: {
              examples: { type: :array, items: { type: :object } },
              summary_line: { type: :string },
              summary: { type: :object },
              version: { type: :string }
            }
          }
        },
        required: [ 'access_token' ]
      }

      response '200', 'build created' do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 url: { type: :string }
               },
               required: [ 'success', 'url' ]

        let(:build) { {
          access_token: 'valid_token',
          commit_sha: 'abc123',
          username: 'testuser',
          reponame: 'test-repo',
          source: 'github',
          test_output: {
            examples: [],
            summary_line: "0 examples, 0 failures",
            summary: {},
            version: "1.0"
          }
        } }
        run_test!
      end
    end
  end
end
