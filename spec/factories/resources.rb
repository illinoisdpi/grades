FactoryBot.define do
  factory :resource do
    context_id { "context_#{SecureRandom.hex(8)}" }
    resource_link_id { "link_#{SecureRandom.hex(8)}" }
    project_url { "https://github.com/testuser/test-repo" }
  end
end
