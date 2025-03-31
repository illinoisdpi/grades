module Build::Passbackable
  extend ActiveSupport::Concern

  included do
    after_create :passback_grade
  end

  def passback_grade
    return unless launch.present? && launch.passback?
    # TODO: only passback highest grade achieved on this assignment (for user)

    # 1. Initialize the LTI ToolProvider with IMS::LTI
    tool_provider = IMS::LTI::ToolProvider.new(
      launch.provider_params["oauth_consumer_key"],
      LtiProvider::Config.secret,
      launch.provider_params
    )

    # 2. Passback result
    response = tool_provider.post_replace_result!(score)

    if response.success?
      Rails.logger.info "Grade passback succeeded for Build ##{id} with score #{score}"
    else
      Rails.logger.error "Grade passback failed: #{response.description}"
    end
  end
end
