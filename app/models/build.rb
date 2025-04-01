class Build < ApplicationRecord
  include Launchable, Passbackable, Resourceable, Scoreable, Userable

  store_accessor :test_output,
   :examples,
   :summary_line,
   :summary,
   :version

  scope :default_order, -> { order(created_at: :desc) }

  def to_s
    "Build ##{id}"
  end
end
