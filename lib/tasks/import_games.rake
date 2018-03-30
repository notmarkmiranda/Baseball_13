require './app/services/baseball_service'

namespace :main do
  task import_games: :environment do
    today = DateTime.today

    p today

    year = today.year.to_s
    month = format_number(today.month)
    day = format_number(today.day)
    b = BaseballService.new(year, month, day)
    games = b.parse_games

    p games

    created_games = games.map do |game|
      Game.find_or_create_by(game.except(:status)) if game_is_final_or_over?(game[:status])
    end.compact

    p created_games

    created_games.each do |game_object|
      home_team = game_object.home_team
      home_accomplishments = home_team.accomplishments.find_by(number: game_object.home_team_score)

      away_team = game_object.away_team
      away_accomplishments = away_team.accomplishments.find_by(number: game_object.away_team_score)

      p away_team.name
      p home_team.name

      home_team.accomplishments.create(team_id: home_team.mlb_id, number: game_object.home_team_score) if eligible?(home_accomplishments, game_object.home_team_score)
      check_for_win(home_team.accomplishments)

      away_team.accomplishments.create(team_id: away_team.mlb_id, number: game_object.away_team_score) if eligible?(away_accomplishments, game_object.away_team_score)
      check_for_win(away_team.accomplishments)
      Event.create(timestamp: Time.zone.now)
    end
  end
end

def check_for_win(accomplishments)
  accomplishments.create(number: 99) if accomplishments.pluck(:number).compact.sort == [*0..13] && no_other_winners?
end

def no_other_winners?
  Team.joins(:accomplishments).where(accomplishments: { number: 99 }).empty?
end

def eligible?(accomplishments, score)
  accomplishments.nil? && score < 14
end

def game_is_final_or_over?(status)
  status.downcase!
  status == 'final' || status == 'game over'
end

def format_number(number)
  return "%02d" % number if number < 10
  number
end
