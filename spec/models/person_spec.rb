require 'rails_helper'

describe Person, type: :model do
 context 'relationships' do
   it { should have_one :team }
 end

 context 'validations' do
   it { should validate_presence_of :name }
   it { should validate_uniqueness_of :name }
 end
 context 'methods'
end
