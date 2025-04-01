class SubmissionsController < ApplicationController
  def validate_token
    # TODO: create Submission model?
    launch = LtiProvider::Launch.find_by(submission_token: params[:token])

    render json: { success: launch.present? }
  end

  def resource
    # launch = LtiProvider::Launch.find_by(submission_token: params[:token])
    # resource = launch.resource
    # full_reponame = resource_info.fetch("repo_slug")
    # remote_spec_folder_sha = resource_info.fetch("spec_folder_sha")
    # source_code_url = resource_info.fetch("source_code_url")
    #
    # resource_info:
    # {
    #   "success"=>true,
    #   "repo_slug"=>"appdev-projects/sinatra-rps",
    #   "spec_folder_sha"=>"c10f5880b5af5a8bc43b4a79b3550d4c37d35c92",
    #   "source_code_url"=>"https://grades-production.s3.amazonaws.com/uploads/resource/source_code/e8582488-ed89-4e01-9595-0025843b46a7/appdev-projects_sinatra-rps.zip"
    # }
    #

    # TODO: hook up storage to github repo to set values dynamically to ensure valid build
    render json: {
      success: true,
      repo_slug: "TODO",
      spec_folder_sha: "TODO",
      source_code_url: "TODO"
    }
  end
end
