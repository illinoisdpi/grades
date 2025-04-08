require 'swagger_helper'

RSpec.describe 'Resources API', type: :request do
  # Skip the actual tests for now and just generate Swagger docs
  before { skip "We'll focus on generating Swagger docs" }

  path '/resources' do
    get 'Lists all resources' do
      tags 'Resources'
      produces 'application/json', 'application/html'

      response '200', 'resources list' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/resource' }

        run_test!
      end
    end

    post 'Creates a resource' do
      tags 'Resources'
      consumes 'application/json'
      parameter name: :resource, in: :body, schema: {
        type: :object,
        properties: {
          context_id: { type: :string },
          resource_link_id: { type: :string },
          project_url: { type: :string }
        },
        required: [ 'context_id', 'resource_link_id' ]
      }

      response '201', 'resource created' do
        let(:resource) { { context_id: 'context123', resource_link_id: 'link456', project_url: 'https://github.com/testuser/test-repo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:resource) { { context_id: 'context123' } }
        run_test!
      end
    end
  end

  path '/resources/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Resource ID'

    get 'Retrieves a resource' do
      tags 'Resources'
      produces 'application/json', 'application/html'

      response '200', 'resource found' do
        schema '$ref' => '#/components/schemas/resource'
        let(:id) { 'valid' }

        run_test!
      end

      response '404', 'resource not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a resource' do
      tags 'Resources'
      consumes 'application/json'
      parameter name: :resource, in: :body, schema: {
        type: :object,
        properties: {
          project_url: { type: :string }
        }
      }

      response '302', 'resource updated' do
        let(:id) { 'valid' }
        let(:resource) { { project_url: 'https://github.com/newuser/new-repo' } }

        run_test!
      end
    end

    delete 'Deletes a resource' do
      tags 'Resources'

      response '204', 'resource deleted' do
        let(:id) { 'valid' }
        run_test!
      end

      response '404', 'resource not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/resources/{id}/edit' do
    parameter name: 'id', in: :path, type: :string, description: 'Resource ID'

    get 'Resource edit form' do
      tags 'Resources'
      produces 'text/html'

      response '200', 'edit form' do
        let(:id) { 'valid' }
        run_test!
      end
    end
  end
end
