require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe 'GET #show' do
    let(:resource) { create(:resource) }

    it 'responds successfully' do
      get :show, params: { id: resource.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    let(:resource) { create(:resource) }

    it 'responds successfully' do
      get :edit, params: { id: resource.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:resource) { create(:resource) }
    let(:new_url) { 'https://github.com/newuser/new-repo' }

    context 'with valid parameters' do
      it 'updates the resource' do
        put :update, params: { id: resource.id, resource: { project_url: new_url } }
        resource.reload
        expect(resource.project_url).to eq(new_url)
      end

      it 'redirects to the resource' do
        put :update, params: { id: resource.id, resource: { project_url: new_url } }
        expect(response).to redirect_to(resource_path(resource))
      end
    end
  end
end
