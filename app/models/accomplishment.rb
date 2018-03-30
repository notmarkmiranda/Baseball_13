class Accomplishment < ApplicationRecord
  belongs_to :team

  def self.team_accomplishment_text(team, number)
    find_by(team_id: team.id, number: number).nil? ? '' : 'X'
  end

  def self.team_accomplishment_exists?(team, number)
    find_by(team_id: team.id, number: number)
  end

  def self.count_by_team(team)
    where("team_id = ? AND number != ?", team.id, 99).count
  end
end
