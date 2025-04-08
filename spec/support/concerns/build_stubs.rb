# This file stubs the modules that are included in the Build model
# for testing purposes

module AttemptNumberable
  extend ActiveSupport::Concern
  included do
    before_validation :assign_attempt_number, on: :create
    scope :max_attempt_number, -> { maximum(:attempt_number) || 0 }
  end

  def assign_attempt_number
    self.attempt_number ||= 1
  end
end

module Launchable
  extend ActiveSupport::Concern
end

module Passbackable
  extend ActiveSupport::Concern
end

module Resourceable
  extend ActiveSupport::Concern
end

module Scoreable
  extend ActiveSupport::Concern
end

module Userable
  extend ActiveSupport::Concern
end

# Monkey patch the Build class for testing
class Build < ApplicationRecord
  include AttemptNumberable, Launchable, Passbackable, Resourceable, Scoreable, Userable
end
