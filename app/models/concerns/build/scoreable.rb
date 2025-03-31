module Build::Scoreable
  extend ActiveSupport::Concern

  included do
    # TODO: refactor to use sql. might need to cache score on table
    scope :highest_score, -> { map { |b| b.score.to_f }.max || 0 }
  end

  def score
    test_output.dig("summary", "score")
  end
end
