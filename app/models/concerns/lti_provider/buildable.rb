require "uri"

# needed to validate oauth signatur: provider.valid_request?
require "oauth/request_proxy/action_controller_request"

module LtiProvider
  module Buildable # TODO: change to initializable
    extend ActiveSupport::Concern

    included do
      validates :canvas_url, :provider_params, :nonce, presence: true

      store :provider_params,
              accessors: [
                :context_id,
                :context_label,
                :context_title,
                :custom_canvas_api_domain,
                :custom_canvas_assignment_id,
                :custom_canvas_assignment_points_possible,
                :custom_canvas_assignment_title,
                :custom_canvas_course_id,
                :custom_canvas_module_id,
                :custom_canvas_module_item_id,
                :custom_canvas_user_id,
                :custom_canvas_user_login_id,
                :custom_canvas_workflow_state,
                :ext_ims_lis_basic_outcome_url,
                :ext_lti_assignment_id,
                :ext_outcome_data_values_accepted,
                :ext_outcome_result_total_score_accepted,
                :ext_outcome_submission_needs_additional_review_accepted,
                :ext_outcome_submission_prioritize_non_tool_grade_accepted,
                :ext_outcome_submission_submitted_at_accepted,
                :ext_outcomes_tool_placement_url,
                :ext_roles,
                :launch_presentation_document_target,
                :launch_presentation_locale,
                :launch_presentation_return_url,
                :lis_outcome_service_url,
                :lis_person_contact_email_primary,
                :lis_person_name_family,
                :lis_person_name_full,
                :lis_person_name_given,
                :lti_message_type,
                :lti_version,
                :oauth_callback,
                :oauth_consumer_key,
                :oauth_nonce,
                :oauth_signature_method,
                :oauth_signature,
                :oauth_timestamp,
                :oauth_version,
                :resource_link_id,
                :resource_link_title,
                :roles,
                :tool_consumer_info_product_family_code,
                :tool_consumer_info_version,
                :tool_consumer_instance_contact_email,
                :tool_consumer_instance_guid,
                :tool_consumer_instance_name,
                :user_id,
                :user_image ]
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
