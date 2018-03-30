class Team < ApplicationRecord
  belongs_to :person, optional: true
  has_many :accomplishments

  def accomplishment_text(number)
    accomplishments.find_by(number: number).nil? ? '' : 'X'
  end

  def accomplishments_count
    accomplishments.where.not(number: 99).count
  end

  def accomplishment_win?
    accomplishments.find_by(number: 99).nil? ? '' : '!!'
  end

  def self.in_order
    left_joins(:accomplishments).group(:id).order('COUNT(accomplishments.id) DESC')
  end

  def winner?
    accomplishments.find_by(number: 99)
  end
end
