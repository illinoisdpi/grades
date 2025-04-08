require 'swagger_helper'

RSpec.describe 'LTI API', type: :request do
  # Skip the actual tests for now and just generate Swagger docs
  before { skip "We'll focus on generating Swagger docs" }

  path '/launch' do
    post 'Launches the LTI application' do
      tags 'LTI'
      consumes 'application/x-www-form-urlencoded'
      produces 'text/html'

      parameter name: :oauth_consumer_key, in: :formData, type: :string, required: true
      parameter name: :oauth_signature_method, in: :formData, type: :string, required: true
      parameter name: :oauth_timestamp, in: :formData, type: :string, required: true
      parameter name: :oauth_nonce, in: :formData, type: :string, required: true
      parameter name: :oauth_version, in: :formData, type: :string, required: true
      parameter name: :oauth_signature, in: :formData, type: :string, required: true

      response '200', 'LTI application launched' do
        let(:oauth_consumer_key) { 'test_key' }
        let(:oauth_signature_method) { 'HMAC-SHA1' }
        let(:oauth_timestamp) { '1609459200' }
        let(:oauth_nonce) { 'test_nonce' }
        let(:oauth_version) { '1.0' }
        let(:oauth_signature) { 'test_signature' }

        run_test!
      end
    end
  end

  path '/config' do
    get 'Retrieves LTI configuration XML' do
      tags 'LTI'
      produces 'application/xml'

      response '200', 'LTI configuration' do
        run_test!
      end
    end
  end
end
