class PagesController < ApplicationController
  def index
    @teams = Team.in_order
    @accomplishments = Accomplishment.all
  end
end
