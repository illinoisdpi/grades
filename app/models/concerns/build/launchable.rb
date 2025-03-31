module Build::Launchable
  extend ActiveSupport::Concern

  included do
    belongs_to :launch, class_name: "LtiProvider::Launch"
  end
end
