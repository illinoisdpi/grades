class BuildsController < ApplicationController
  def create
    launch = LtiProvider::Launch.find_by(submission_token: params[:access_token])
    resource = launch.resource
    build = Build.create(build_params.merge({ launch:, resource: }))

    render json: {
      success: true,
      url: resource_url(build.resource)
    }
  end

  private

  def build_params
    params.require(:build).permit(:access_token, :commit_sha, :username, :reponame, :source, test_output: {})
  end
end
