FactoryBot.define do
  factory :lti_provider_launch, class: 'LtiProvider::Launch' do
    canvas_url { "https://canvas.example.com" }
    nonce { SecureRandom.hex(16) }
    provider_params { {} }
    submission_token { SecureRandom.hex(16) }
    association :resource
    association :lti_provider_user
  end
end
