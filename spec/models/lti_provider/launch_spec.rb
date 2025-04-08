require 'rails_helper'

RSpec.describe LtiProvider::Launch, type: :model do
  describe 'includes' do
    it 'includes the required modules' do
      modules = LtiProvider::Launch.included_modules
      expect(modules).to include(LtiProvider::Initializeable)
      expect(modules).to include(LtiProvider::Resourceable)
      expect(modules).to include(LtiProvider::Roleable)
      expect(modules).to include(LtiProvider::Tokenable)
      expect(modules).to include(LtiProvider::Userable)
      expect(modules).to include(LtiProvider::XmlConfigurable)
    end
  end
end
