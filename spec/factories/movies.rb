FactoryBot.define do
  factory :movie do
    sequence(:title) { |i| "Detailed movie description #{i}"}
  end
end