require "ims/lti"

class LtiProvider::GradesController < ApplicationController
  skip_before_action :verify_authenticity_token # LTI launches need this skip

  def submit_grade
    debugger
    launch = LtiProvider::Launch.find_by(nonce: params[:nonce])

    unless launch
      render plain: "Invalid launch", status: :forbidden
      return
    end

    consumer_key = launch.provider_params["oauth_consumer_key"]
    consumer_secret = "secret" # Match this with Canvas config

    # Retrieve the grade passback URL and sourcedid from the launch params
    outcome_url = launch.provider_params["lis_outcome_service_url"]
    sourcedid = launch.provider_params["ext_lti_assignment_id"]

    # Setup the outcome request
    tool_provider = IMS::LTI::ToolProvider.new(consumer_key, consumer_secret, launch.provider_params)

    # Grade should be between 0 and 1 (e.g., 0.95 for 95%)
    res = tool_provider.post_replace_result!(0.95)

    if res.success?
      render plain: "Grade submitted successfully"
    else
      render plain: "Grade submission failed: #{res.description}", status: :internal_server_error
    end
  end
end
