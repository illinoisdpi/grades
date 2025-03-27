class ResourcesController < ApplicationController
  def show
    @resource = Resource.find(params[:id])
    @launch = LtiProvider::Launch.find_by(nonce: session[:launch_nonce])

    # The URL can be saved on Resource, set by instructor, or a constant.
    @project_url = @resource.project_url
    @builds = @resource.builds.for_user(Current.lti_provider_user).default_order

    if @project_url.nil?
      render plain: "Missing Project URL. Please contact course owner."
    elsif @launch.nil?
      # TODO: fix this bug on first launch
      render plain: "Unable to find launch. Please relaunch from canvas."
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      redirect_to resource_path(@resource), notice: "Project URL set!"
    else
      render :edit
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:project_url)
  end
end
