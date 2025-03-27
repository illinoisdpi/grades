module Current::LtiProviderUserable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_lti_provider_user
  end

  private

  def set_current_lti_provider_user
    return unless session[:launch_nonce].present?

    launch = LtiProvider::Launch.find_by(nonce: session[:launch_nonce])
    return unless launch

    Current.lti_provider_user = launch.user
  end
end
