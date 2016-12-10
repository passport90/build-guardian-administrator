FactoryGirl.define do
  factory :engineer do
    slack_username { Faker::Internet.user_name }
    duty_fulfilled { false }
    duty_owed { false }
  end
end
