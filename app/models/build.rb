class Build < ApplicationRecord
  belongs_to :launch, class_name: "LtiProvider::Launch"
  belongs_to :resource
  # has_one :user (through launch?)

  store_accessor :test_output, :version, :examples, :summary, :summary_line

  scope :default_order, -> { order(created_at: :desc) }

  # passbackable
  after_create :passback_grade

  def passback_grade
    return unless launch.present? && launch.passback?
    # TODO: only passback highest grade achieved on this assignment (for user)
    #

    # TODO: check launch provider_params for lis_result_sourcedid and lis_outcome_service_url

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

  def score
    test_output.dig("summary", "score")
  end
end
