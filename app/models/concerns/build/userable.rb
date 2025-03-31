module Build::Userable
  extend ActiveSupport::Concern

  included do
    belongs_to :user, class_name: "LtiProvider::User", foreign_key: "lti_provider_user_id"
    before_validation :set_user, on: :create

    scope :for_user, ->(user) { where(user:) }
  end

  def set_user
    self.user ||= launch.user
  end
end
