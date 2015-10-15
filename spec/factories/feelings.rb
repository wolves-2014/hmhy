FactoryGirl.define do
  factory :feeling do
    word 'tired'
    rank 1

    trait :secondary do
      word 'sleeping too much'
      rank 2
    end

    trait :tertiary do
      word 'indecisive'
      rank 3
    end
  end
end

