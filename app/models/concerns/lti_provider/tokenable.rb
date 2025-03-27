module LtiProvider
  module Tokenable
    extend ActiveSupport::Concern

    included do
      before_validation :generate_submission_token, on: :create
      validates :submission_token, presence: true, uniqueness: true
    end

    class_methods do
      def generate_token
        chars = ("1".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a - %w[O I l]
        loop do
          token = (0...24).map { chars.sample }.join
          break token unless exists?(submission_token: token)
        end
      end
    end

    private

    def generate_submission_token
      self.submission_token ||= self.class.generate_token
    end
  end
end
