module LtiProvider
  module Userable
    extend ActiveSupport::Concern

    included do
      belongs_to :user, class_name: "LtiProvider::User", foreign_key: "lti_provider_user_id"
      before_validation :assign_user, on: :create
    end

    def assign_user
      lis_user_id = provider_params["user_id"]
      return if lis_user_id.blank?

      self.user ||= User.find_or_create_by(lis_user_id:) do |u|
        u.tool_consumer_instance_name      = provider_params["tool_consumer_instance_name"]
        u.lis_person_name_given            = provider_params["lis_person_name_given"]
        u.lis_person_name_family           = provider_params["lis_person_name_family"]
        u.lis_person_name_full             = provider_params["lis_person_name_full"]
      end
    end
  end
end
