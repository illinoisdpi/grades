class Build < ApplicationRecord
  belongs_to :launch, class_name: "LtiProvider::Launch"
  belongs_to :resource
  # has_one :user (through launch?)

  store_accessor :test_output, :version, :examples, :summary, :summary_line

  scope :default_order, -> { order(created_at: :desc) }
end
