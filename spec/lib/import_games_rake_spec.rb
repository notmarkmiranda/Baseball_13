require 'rails_helper'

describe 'main:import_games' do
  include_context 'rake'
  include ActiveSupport::Testing::TimeHelpers

  let(:b) { double('BaseballService') }
  let(:games_hashes) {
    [
      {:away_team_id=>"141", :home_team_id=>"147", :away_team_score=>"1", :home_team_score=>"9", :status=>"Final", :game_id=>"2018/04/21/tormlb-nyamlb-1"},
      {:away_team_id=>"118", :home_team_id=>"116", :away_team_score=>"4", :home_team_score=>"12", :status=>"Final", :game_id=>"2018/04/21/kcamlb-detmlb-1"}
    ]
  }

  let(:second_games_hashes) {
    [
      {:away_team_id=>"141", :home_team_id=>"147", :away_team_score=>"1", :home_team_score=>"9", :status=>"Final", :game_id=>"2018/04/21/tormlb-nyamlb-1"},
      {:away_team_id=>"118", :home_team_id=>"116", :away_team_score=>"16", :home_team_score=>"12", :status=>"Final", :game_id=>"2018/04/21/kcamlb-detmlb-1"}
    ]
  }

  before do
    create(:team, mlb_id: 141)
    @team_2 = create(:team, mlb_id: 147)
    create(:team, mlb_id: 118)
    @team_4 = create(:team, mlb_id: 116)
    @team_5 = create(:team, mlb_id: 117)
    @team_6 = create(:team, mlb_id: 119, person: nil)

    allow(BaseballService).to receive(:new).and_return(b)
    allow(b).to receive(:parse_games).and_return(games_hashes)
  end

  it 'creates 2 games' do
    expect {
      subject.invoke
    }.to change(Game, :count).by(2)
  end

  it 'creates 4 accomplishments' do
    expect {
      subject.invoke
    }.to change(Accomplishment, :count).by(4)
  end

  it 'does not create an accomplishment for a number when one already exists' do
    create(:accomplishment, team: @team_2, number: 9)

    expect {
      subject.invoke
    }.to change(Accomplishment, :count).by(3)
  end

  it 'creates a win for a team that has all wins' do
    14.times { |x| create(:accomplishment, team: @team_4, number: x) unless x == 12 }

    subject.invoke
    expect(@team_4.winner?).to be_truthy
  end

  it 'does not create an accomplishment for a score greater than 13' do
    allow(b).to receive(:parse_games).and_return(second_games_hashes)

    expect {
      subject.invoke
    }.to change(Accomplishment, :count).by(3)
  end

  it 'creates a winner if other win is on the same day' do
    14.times { |x| create(:accomplishment, team: @team_2, number: x) unless x == 9 }
    14.times { |x| create(:accomplishment, team: @team_4, number: x) unless x == 12 }

    subject.invoke
    expect(@team_2.winner?).to be_truthy
    expect(@team_4.winner?).to be_truthy
  end

  it 'creates a winner if other team with win does not have user' do
    14.times { |x| create(:accomplishment, team: @team_2, number: x) unless x == 9 }
    14.times { |x| create(:accomplishment, team: @team_6, number: x) }
    create(:accomplishment, team: @team_6, number: 99)

    subject.invoke
    expect(@team_2.winner?).to be_truthy
  end

  it 'creates a winner if other team with win is from previous day with no user' do
    travel_to(1.day.ago)  do
      14.times { |x| create(:accomplishment, team: @team_2, number: x) unless x == 9 }
      14.times { |x| create(:accomplishment, team: @team_6, number: x) }
      create(:accomplishment, team: @team_6, number: 99)
    end

    subject.invoke
    expect(@team_2.winner?).to be_truthy
  end

  it 'doesnt create a winner if other win is from previous day with user' do
    travel_to(1.day.ago)  do
      14.times { |x| create(:accomplishment, team: @team_2, number: x) }
      create(:accomplishment, team: @team_2, number: 99)
      14.times { |x| create(:accomplishment, team: @team_4, number: x) unless x == 12 }
    end

    subject.invoke
    expect(@team_4.winner?).to be_falsy
  end

  it 'adds creates a winner if other win is from previous day with user - yesterday true' do
    travel_to(1.day.ago)  do
      14.times { |x| create(:accomplishment, team: @team_2, number: x) }
      create(:accomplishment, team: @team_2, number: 99)
      14.times { |x| create(:accomplishment, team: @team_4, number: x) unless x == 12 }
    end

    subject.invoke('true')
    expect(@team_4.winner?).to be_truthy
  end

  it 'creates a winner if other team with win does not have user - yesterday true' do
    14.times { |x| create(:accomplishment, team: @team_2, number: x) unless x == 9 }
    14.times { |x| create(:accomplishment, team: @team_6, number: x) }
    create(:accomplishment, team: @team_6, number: 99)

    subject.invoke('true')
    expect(@team_2.winner?).to be_truthy
  end
end
