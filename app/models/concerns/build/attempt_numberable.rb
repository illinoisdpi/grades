module Build::AttemptNumberable
  extend ActiveSupport::Concern

  included do
    before_validation :assign_attempt_number, on: :create

    scope :max_attempt_number, -> { maximum(:attempt_number) || 0 }
  end

  def assign_attempt_number
    max_attempt_number = Build.for_user(user).for_resource(resource).max_attempt_number

    self.attempt_number ||= max_attempt_number + 1
  end
end
