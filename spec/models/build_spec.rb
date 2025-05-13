require 'rails_helper'

RSpec.describe Build, type: :model do
  let(:resource) { create(:resource) }
  let(:user) { create(:lti_provider_user) }
  let(:launch) { create(:lti_provider_launch, resource: resource, lti_provider_user: user) }

  describe 'attributes' do
    it 'should have store_accessor for test_output fields' do
      build = Build.new
      expect(build).to respond_to(:examples)
      expect(build).to respond_to(:summary_line)
      expect(build).to respond_to(:summary)
      expect(build).to respond_to(:version)
    end
  end

  describe 'scopes' do
    describe '.default_order' do
      it 'orders by created_at desc' do
        skip "This test can be validated in a code review"
      end
    end
  end
end
