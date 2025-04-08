FactoryBot.define do
  factory :lti_provider_user, class: 'LtiProvider::User' do
    lis_person_name_given { "John" }
    lis_person_name_family { "Doe" }
    lis_person_name_full { "John Doe" }
    lis_user_id { "user_#{SecureRandom.hex(8)}" }
    tool_consumer_instance_name { "Test School" }
  end
end
