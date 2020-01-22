FactoryBot.define do
  factory :movie do
    search
    sequence(:description) { |i| "Detailed movie description #{i}"}
  end
end