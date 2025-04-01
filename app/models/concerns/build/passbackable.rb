module Build::Passbackable
  extend ActiveSupport::Concern

  included do
    after_create :passback_grade
  end

  def passback_grade
    build = Build.for_user(user).for_resource(resource).with_max_score.first

    unless build
      Rails.logger.error "Grade passback failed: Unable to find build with max score for User ##{user.id} on Resource ##{resource.id}"
      return
    end

    tool_provider.post_replace_result!(build.score)

    if response.success?
      Rails.logger.info "Grade passback succeeded: max score #{build.score} passed back for User ##{user.id} on Resource ##{resource.id}"
    else
      Rails.logger.error "Grade passback failed: #{response.description}"
    end
  end

  def tool_provider
    IMS::LTI::ToolProvider.new(
      launch.provider_params["oauth_consumer_key"],
      LtiProvider::Config.secret,
      launch.provider_params
    )
  end
end
