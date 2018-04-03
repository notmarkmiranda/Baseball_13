require 'rails_helper'

describe Game, type: :model do
  context 'relationships'
  context 'validations' do
    it { should validate_presence_of :game_id }
    it { should validate_uniqueness_of :game_id }
  end

  context 'methods' do
    context '#home_team' do
      it 'returns the home team'
    end

    context '#away_team' do
      it 'returns the away team'
    end
  end
end
