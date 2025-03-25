class ApplicationController < ActionController::Base
  # TODO: skip CSRF protection for LtiProvider::LtiController#launch
  # skip_before_action :verify_authenticity_token

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
