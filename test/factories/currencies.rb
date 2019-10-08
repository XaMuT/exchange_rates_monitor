FactoryBot.define do
  factory :currency do
    abbr      { FFaker::Currency.code }
    name      { FFaker::Currency.name }
    cbrf_code { FFaker::String.from_regexp(/\d+abc/) }
  end
end

