class BuildsController < ApplicationController
  before_action :set_build, only: [ :show ]
  before_action :set_launch, only: [ :create ]

  def create
    build = Build.create(build_params.merge({ launch: @launch }))

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

  def set_launch
    @launch = LtiProvider::Launch.find_by(submission_token: params[:access_token])
  end
end
