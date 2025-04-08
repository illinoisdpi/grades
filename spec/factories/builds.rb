FactoryBot.define do
  factory :build do
    association :launch, factory: :lti_provider_launch
    association :resource
    association :lti_provider_user
    test_output { { "examples" => [], "summary_line" => "0 examples, 0 failures", "summary" => {}, "version" => "1.0" } }
    commit_sha { SecureRandom.hex(20) }
    username { "testuser" }
    reponame { "test-repo" }
    source { "github" }
    score { 0.0 }
    attempt_number { 1 }

    trait :with_test_output do
      test_output {
        {
          "examples" => [
            { "status" => "passed", "full_description" => "Test 1 passes" },
            { "status" => "passed", "full_description" => "Test 2 passes" }
          ],
          "summary_line" => "2 examples, 0 failures",
          "summary" => { "example_count" => 2, "failure_count" => 0 },
          "version" => "1.0"
        }
      }
      score { 100.0 }
    end
  end
end
