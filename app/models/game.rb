class Game < ApplicationRecord
  validates :game_id, uniqueness: true, presence: true
  validates :home_team_id, uniqueness: { scope: :away_team_id }

  def home_team
    Team.find_by(mlb_id: home_team_id)
  end

  def away_team
    Team.find_by(mlb_id: away_team_id)
  end
end
