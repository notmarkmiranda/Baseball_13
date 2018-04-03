FactoryBot.define do
  factory :team do
    sequence :name { |n| "Team Name - #{n}" }
    sequence :mlb_id { |n| "team_#{n}" }
    person
  end
end
