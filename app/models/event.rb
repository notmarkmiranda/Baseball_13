class Event < ApplicationRecord
  default_scope { order(timestamp: :desc) }

  def format_date_time
    timestamp.in_time_zone('Mountain Time (US & Canada)').strftime('%B %d, %Y at %l:%M%p %Z')
  end
end
