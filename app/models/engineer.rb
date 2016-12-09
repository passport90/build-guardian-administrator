class Engineer < ApplicationRecord
  validates :slack_username, presence: true, uniqueness: true
  validates :duty_date, uniqueness: true, allow_nil: true
  validates :duty_fulfilled, exclusion: { in: [nil] }
end
