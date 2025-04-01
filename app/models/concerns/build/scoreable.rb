module Build::Scoreable
  extend ActiveSupport::Concern

  included do
    before_validation :set_score
    validates :score, numericality: { in: 0.0..1.0 }
    scope :highest_score, -> { maximum(:score) }
  end

  def set_score
    self.score ||= test_output.dig("summary", "score").to_f
  end
end
