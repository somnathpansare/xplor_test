# spec/factories/books.rb
FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    status { 'available' }
    author { 'somnath' }
    library

    trait :checked_out do
      status { 'checked_out' }
      checked_out_by_user
    end
  end
end
