require "oauth/request_proxy/action_controller_request"

module LtiProvider
  class LtiController < ApplicationController
    include LtiProvider::LtiApplication
    skip_before_action :require_lti_launch

    def launch
      provider = IMS::LTI::ToolProvider.new(
        params["oauth_consumer_key"],
        LtiProvider::Config.secret,
        params
      )

      @launch = LtiProvider::Launch.initialize_from_request(provider, request)

      # Create or find a resource here (an assignment/project) if needed.
      resource = Resource.find_or_create_by(
        context_id: @launch.provider_params["context_id"],
        resource_link_id: @launch.provider_params["resource_link_id"]
      )

      @launch.resource = resource

      # TODO: is this getting saved on first launch?
      @launch.save

       session[:launch_nonce] = @launch.nonce

      if @launch.instructor?
        if resource.project_url.blank?
          redirect_to main_app.edit_resource_path(resource)
          return
        end
      end

      redirect_to main_app.resource_path(resource)
    end

    def configuration
      respond_to do |format|
        format.xml do
          render xml: Launch.xml_config(lti_launch_url)
        end
      end
    end
  end
end
