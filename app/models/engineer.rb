class Engineer < ApplicationRecord
  validates :slack_username, presence: true, uniqueness: true
  validates :duty_date, uniqueness: true
  validates :duty_fulfilled, exclusion: { in: [nil] }
end
