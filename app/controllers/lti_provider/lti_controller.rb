module LtiProvider
  class LtiController < ApplicationController
    before_action :set_provider, only: [ :launch ]
    before_action :set_launch, only: [ :launch ]

    def launch
      if @launch.save
        session[:launch_nonce] = @launch.nonce
      else
        render plain: @launch.errors.full_messages, status: :unprocessable_entity
        return
      end

      if @launch.instructor? && @launch.resource.project_url.blank?
        redirect_to main_app.edit_resource_path(@launch.resource)
      else
        redirect_to main_app.resource_path(@launch.resource)
      end
    end

    def configuration
      respond_to do |format|
        format.xml do
          render xml: Launch.xml_config(lti_launch_url)
        end
      end
    end

    private

    def set_provider
      @provider = IMS::LTI::ToolProvider.new(
        params["oauth_consumer_key"],
        LtiProvider::Config.secret,
        params
      )
    end

    def set_launch
      @launch = LtiProvider::Launch.from_lti_request(@provider, request)
    end
  end
end
