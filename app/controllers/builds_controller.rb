class BuildsController < ApplicationController
  before_action :set_build, only: [ :show ]

  def create
    launch = LtiProvider::Launch.find_by(submission_token: params[:access_token])
    resource = launch.resource
    # TODO: set resource during a before_validation callback
    build = Build.create(build_params.merge({ launch:, resource: }))

    render json: {
      success: true,
      url: resource_url(build.resource)
    }
  end

  def show
    @breadcrumbs = [
      { content: @build.resource.to_s, href: resource_path(@build.resource) },
      { content: @build.to_s }
    ]
  end

  private

  def build_params
    params.require(:build).permit(:access_token, :commit_sha, :username, :reponame, :source, test_output: {})
  end

  def set_build
    @build = Build.find_by(id: params[:id])
  end
end
