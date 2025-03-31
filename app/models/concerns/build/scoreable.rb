module Build::Scoreable
  extend ActiveSupport::Concern

  # TODO: validate score in range 0.0 -> 1.0

  included do
    before_validation :set_score

    scope :highest_score, -> { maximum(:score) }
  end

  def set_score
    self.score ||= test_output.dig("summary", "score").to_f
  end
end
