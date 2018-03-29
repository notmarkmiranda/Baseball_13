class Team < ApplicationRecord
  belongs_to :person, optional: true
  has_many :accomplishments

  def accomplishment_text(number)
    accomplishments.find_by(number: number).nil? ? '' : 'X'
  end

  def self.in_order
    self.left_joins(:accomplishments)
        .group(:id)
        .order('COUNT(accomplishments.id) DESC')
  end
end
