require 'rails_helper'

describe Team, type: :model do
  context 'relationships' do
    it { should belong_to :person }
    it { should have_many :accomplishments }
  end

  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :mlb_id }
    it { should validate_uniqueness_of :mlb_id }
  end

  context 'methods' do
    let(:team) { create(:team) }

    context '#accomplishment_text' do
      subject { team.accomplishment_text(4) }

      it 'returns nothing' do
        expect(subject).to eq('')
      end

      it 'returns X' do
        create(:accomplishment, number: 4, team: team)

        expect(subject).to eq('X')
      end
    end

    context '#accomplishments_count' do
      subject { team.accomplishments_count }

      it 'returns 0' do
        expect(subject).to eq(0)
      end

      it 'returns 0 with 99 accomplishment' do
        create(:accomplishment, number: 99, team: team)

        expect(subject).to eq(0)
      end

      it 'returns 2' do
        create(:accomplishment, number: 3, team: team)
        create(:accomplishment, number: 4, team: team)

        expect(subject).to eq(2)
      end
    end

    context '#accomplishment_win?' do
      subject { team.accomplishment_win? }

      it 'returns nothing' do
        expect(subject).to eq('')
      end

      it 'returns !!' do
        create(:accomplishment, number: 99, team: team)

        expect(subject).to eq('!!')
      end
    end

    context 'self#in_order'
    context '#winner?' do
      it 'returns true' do
        create(:accomplishment, team: team, number: 99)

        expect(team.winner?).to be_truthy
      end

      it 'returns false' do
        expect(team.winner?).to be_falsy
      end
    end
  end
end
