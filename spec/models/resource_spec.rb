require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:context_id) }
    it { should validate_presence_of(:resource_link_id) }
  end

  describe 'associations' do
    it { should have_many(:builds) }
  end

  describe '#project_path' do
    let(:resource) { build(:resource, project_url: 'https://github.com/testuser/test-repo') }

    it 'returns the path portion of the project URL without leading slash' do
      expect(resource.project_path).to eq('testuser/test-repo')
    end
  end

  describe '#to_s' do
    let(:resource) { build(:resource, project_url: 'https://github.com/testuser/test-repo') }

    it 'returns a string representation with ID and project path' do
      allow(resource).to receive(:id).and_return('123')
      expect(resource.to_s).to eq('Resource #123: testuser/test-repo')
    end
  end
end
