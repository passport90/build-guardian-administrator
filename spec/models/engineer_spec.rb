require 'rails_helper'

describe Engineer do
  subject { build :engineer }
  it { should validate_presence_of(:slack_username) }
  it { should validate_uniqueness_of(:slack_username) }
  it { should validate_uniqueness_of(:duty_date) }
  it { should validate_exclusion_of(:duty_fulfilled).in_array([nil]) }
end
