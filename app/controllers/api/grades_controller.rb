require "ims/lti"

# TODO: no need for module
module Api
  class GradesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      nonce = params[:lti_nonce]
      score = params[:score].to_f

      launch = LtiProvider::Launch.find_by(nonce: nonce)

      unless launch
        render json: { error: "Invalid launch nonce" }, status: :not_found
        return
      end

      consumer_key = launch.provider_params["oauth_consumer_key"]
      consumer_secret = ENV["LTI_SHARED_SECRET"]

      tool_provider = IMS::LTI::ToolProvider.new(consumer_key, consumer_secret, launch.provider_params)
      result = tool_provider.post_replace_result!(score)

      if result.success?
        render json: { message: "Grade successfully submitted" }, status: :ok
      else
        render json: { error: result.description }, status: :unprocessable_entity
      end
    end
  end
end
