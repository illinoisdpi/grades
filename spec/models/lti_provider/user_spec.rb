require 'rails_helper'

RSpec.describe LtiProvider::User, type: :model do
  describe 'associations' do
    it { should have_many(:launches).class_name('LtiProvider::Launch').with_foreign_key('lti_provider_user_id') }
  end
end
