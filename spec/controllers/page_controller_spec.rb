require 'rails_helper'

RSpec.describe PageController, type: :controller do
  describe 'GET #landing' do
    it 'responds successfully' do
      get :landing
      expect(response).to be_successful
    end
  end
end
