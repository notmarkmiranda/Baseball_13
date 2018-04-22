require 'rails_helper'

describe Game, type: :model do
  context 'relationships'

  context 'validations' do
    it { should validate_presence_of :game_id }
    it { should validate_uniqueness_of :game_id }
    it { should validate_uniqueness_of(:home_team_id).scoped_to(:away_team_id) }
  end

  context 'methods' do
    let(:game) { create(:game) }

    context '#home_and_away_team' do
      let(:home_team) { game.home_team }
      let(:away_team) { game.away_team }

      it 'returns the home team' do
        expect(game.home_team).to eq(home_team)
        expect(game.away_team).to eq(away_team)
      end
    end
  end
end
