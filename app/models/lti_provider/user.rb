class LtiProvider::User < ApplicationRecord
  has_many :launches, class_name: "LtiProvider::Launch", foreign_key: "lti_provider_user_id"
end
