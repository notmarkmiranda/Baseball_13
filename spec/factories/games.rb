FactoryBot.define do
  factory :game do
    sequence :game_id { |x| "newgame/3/29/team1_team2#{x}" }
    home_team_score 1
    away_team_score 0
    home_team_id { create(:team, mlb_id: 999).mlb_id }
    away_team_id { create(:team, mlb_id: 998).mlb_id }
  end
end
