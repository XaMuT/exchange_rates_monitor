FactoryGirl.define do
  factory :rate do
    association :currency
    value     { FFaker::String.from_regexp(/\d{2}\.\d{4}/).to_f }

    factory :regular_rate do
      type    "Rate::RegularRate"
      date    { FFaker::Time.date }
    end

    factory :forced_rate do
      type    "Rate::ForcedRate"
      ends_at { Time.zone.now + 1.day }
    end
  end
end
