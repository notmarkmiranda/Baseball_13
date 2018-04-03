FactoryBot.define do
  factory :person do
    sequence :name { |n| "Mark #{n}" }
  end
end
