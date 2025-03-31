class Build < ApplicationRecord
  # TODO: move to launchable?
  belongs_to :launch, class_name: "LtiProvider::Launch"

  # TODO: move to resourceable
  belongs_to :resource

  before_validation :set_resource, on: :create

  def set_resource
    self.resource ||= launch.resource
  end

  # TODO: move to userable
  belongs_to :user, class_name: "LtiProvider::User", foreign_key: "lti_provider_user_id"

  before_validation :set_user, on: :create

  def set_user
    self.user ||= launch.user
  end

  store :test_output,
          accessors: [
            :examples,
            :summary_line,
            :summary,
            :version ]

  scope :default_order, -> { order(created_at: :desc) }
  # TODO: refactor so it only uses launches for this resource
  scope :for_user, ->(user) { where(user:) }

  # TODO: refactor to use sql
  scope :highest_score, -> { map { |b| b.score.to_f }.max || 0 }

  # passbackable
  after_create :passback_grade

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

  # TODO: scoreable
  def score
    test_output.dig("summary", "score")
  end

  def to_s
    "Build ##{id}"
  end
end
