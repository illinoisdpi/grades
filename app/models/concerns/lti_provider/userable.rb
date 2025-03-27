module LtiProvider
  module Userable
    extend ActiveSupport::Concern

    included do
      belongs_to :user, class_name: "LtiProvider::User", foreign_key: "lti_provider_user_id"
      before_validation :assign_user, on: :create
    end

    def assign_user
      canvas_user_id = provider_params["custom_canvas_user_id"]
      lis_user_id = provider_params["user_id"]
      return if canvas_user_id.blank? && lis_user_id.blank?

      self.user ||= User.find_or_create_by(canvas_user_id: canvas_user_id) do |u|
        u.lis_person_name_full             = provider_params["lis_person_name_full"]
        u.lis_user_id                      = provider_params["user_id"]
        u.lis_person_contact_email_primary = provider_params["lis_person_contact_email_primary"]
        u.user_image                       = provider_params["user_image"]
      end
    end
  end
end
