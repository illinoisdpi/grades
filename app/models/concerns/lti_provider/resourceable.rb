module LtiProvider
  module Resourceable
    extend ActiveSupport::Concern

    included do
      belongs_to :resource
      before_validation :set_resource
    end

    def set_resource
      self.resource ||= Resource.find_or_create_by(
        context_id: provider_params["context_id"],
        resource_link_id: provider_params["resource_link_id"]
      )
    end
  end
end
