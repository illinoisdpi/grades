class BuildsController < ApplicationController
  def create
    # TODO: create Build model
    #     belongs_to :launch
    #     belongs_to :resource
    #     belongs_to :user

    debugger
    @launch = LtiProvider::Launch.find_by(submission_token: params[:access_token])

    render json: {
      success: true,
      # TODO: redirect to full url
      url: resource_url(@launch.resource)
    }
  end

  private

  def build_params
    params.require(:build).permit(:access_token, :test_output, :commit_sha, :username, :reponame, :source)
  end
end
