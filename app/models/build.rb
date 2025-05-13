class Build < ApplicationRecord
  include AttemptNumberable, Launchable, Passbackable, Resourceable, Scoreable, Userable

  store_accessor :test_output,
   :examples,
   :summary_line,
   :summary,
   :version

  scope :default_order, -> { order(created_at: :desc) }

  def to_breadcrumb_s
    "Build ##{attempt_number}"
  end
end
