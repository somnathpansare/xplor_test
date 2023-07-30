FactoryBot.define do
  factory :library do
    sequence(:name) { |n| "Library #{n}" }
    book_limits { 100 }
  end
end