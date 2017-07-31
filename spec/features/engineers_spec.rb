require 'rails_helper'

describe "engineers page", :type => :feature do
  let!(:engineers) { create_list :engineer, 2 }
  let!(:now) { Time.now }
  let!(:today) { Date.today }
  before { allow(today).to receive(:wday) { Random.rand(1..5) }  }
  before { allow(Date).to receive(:today) { today }  }
  before { allow(Time).to receive(:now) { now.change hour: Random.rand(0...12) } }

  before do
    visit "/"
    fill_in "login[password]", with: "queenjaneapproximately"
    click_button "Login"
  end

  it "show all engineers" do
    visit engineers_path
    expect(page).to have_text engineers.first.slack_username
    expect(page).to have_text engineers.last.slack_username
  end

  it "edit an engineer" do
    visit engineers_path

    selector = ".engineers-edit[data-id='#{engineers.first.id}']"
    find(selector).click

    fill_in 'Slack username', with: 'new username'
    click_button 'Submit'

    expect(page).to have_text "new username"
  end

  it "delete an engineer" do
    visit engineers_path

    selector = ".engineers-delete[data-id='#{engineers.first.id}']"
    find(selector).click

    expect(page).not_to have_text engineers.first.slack_username
  end

  it "create an engineer" do
    visit engineers_path

    selector = ".engineers-add"
    find(selector).click

    fill_in 'Slack username', with: 'new engineer'
    click_button 'Submit'

    expect(page).to have_text "new engineer"
  end
end
