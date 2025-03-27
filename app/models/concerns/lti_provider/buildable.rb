require "uri"

# needed to validate oauth signatur: provider.valid_request?
require "oauth/request_proxy/action_controller_request"

module LtiProvider
  module Buildable
    extend ActiveSupport::Concern

    included do
      validates :canvas_url, :provider_params, :nonce, presence: true

      # TODO: change to jsonb
      serialize :provider_params
    end

    class_methods do
      def from_lti_request(provider, request)
        new(
          provider_params: provider.to_params,
          canvas_url:      parse_canvas_url(provider.launch_presentation_return_url),
          nonce:           provider.to_params["oauth_nonce"]
        ).tap do |launch|
          launch.validate_provider(provider, request)
        end
      end

      private

      def parse_canvas_url(return_url)
        return unless return_url

        uri = URI.parse(return_url)
        domain = "#{uri.scheme}://#{uri.host}"
        domain += ":#{uri.port}" unless [ 80, 443, nil ].include?(uri.port)
        domain
      end
    end

    def passback?
      provider_params["lis_result_sourcedid"].present? &&
        provider_params["lis_outcome_service_url"].present?
    end

    def validate_provider(provider, request)
      if provider.consumer_key.blank?
        errors.add(:lti, "Consumer key not provided.")
      elsif provider.consumer_secret.blank?
        errors.add(:lti, "Consumer secret not configured on provider.")
      elsif !provider.valid_request?(request)
        errors.add(:lti, "The OAuth signature was invalid.")
      elsif oauth_timestamp_too_old?(provider.request_oauth_timestamp)
        errors.add(:lti, "Your request is too old.")
      end
    end

    private

    def oauth_timestamp_too_old?(timestamp)
      Time.now.utc.to_i - timestamp.to_i > 1.hour.to_i
    end
  end
end
