module Build::Resourceable
  extend ActiveSupport::Concern

  included do
    belongs_to :resource
    before_validation :set_resource, on: :create
  end

  def set_resource
    self.resource ||= launch.resource
  end
end
