require 'net/http'

class BaseballService
  attr_reader :uri
  def initialize(year, month, day)
    url = "http://gd2.mlb.com/components/game/mlb/year_#{year}/month_#{month}/day_#{day}/master_scoreboard.json"
    @uri = URI(url)
  end

  def parse_games
    response = Net::HTTP.get(uri)
    response_parser(JSON.parse(response))
  end

  private

  def response_parser(response)
    games = response['data']['games']['game']
    games.map { |game| create_game_info(game) }
  end

  def create_game_info(game)
    linescore = game['linescore']
    status = game['status']
    
    game_info = {}
    game_info[:away_team_id] = game['away_team_id']
    game_info[:home_team_id] = game['home_team_id']
    game_info[:away_team_score] = game['linescore']['r']['away'] if linescore
    game_info[:home_team_score] = game['linescore']['r']['home'] if linescore
    game_info[:status] = game['status']['status'] if status
    game_info[:game_id] = game['id']
    game_info
  end
end
