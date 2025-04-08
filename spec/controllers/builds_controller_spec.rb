require 'rails_helper'

RSpec.describe BuildsController, type: :controller do
  describe 'GET #show' do
    it 'responds successfully' do
      resource = double(to_s: "Resource #1", id: "1", to_param: "1")
      build = double(id: '123', to_param: '123', to_s: "Build #123", resource: resource)

      allow(Build).to receive(:find_by).with(id: '123').and_return(build)

      get :show, params: { id: '123' }
      expect(response).to be_successful
    end
  end
end
