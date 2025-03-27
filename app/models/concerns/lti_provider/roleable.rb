module LtiProvider
  module Roleable
    extend ActiveSupport::Concern

    LTI_ROLES = [
      "Instructor",
      "Learner"
      # TODO: add more roles as needed
    ]

    included do
      # Dynamically define, e.g. #instructor?, #learner?, etc.
      LTI_ROLES.each do |role_name|
        method_name = "#{role_name.downcase}?".to_sym

        define_method(method_name) do
          roles.include?(role_name)
        end
      end
    end

    def roles
      provider_params.fetch("roles", "")
    end
  end
end
