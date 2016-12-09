require 'rails_helper'

describe "main page", :type => :feature do

  let!(:now) { Time.now }
  context "morning" do
    before do
      allow(Time).to receive(:now) { now.change hour: Random.rand(7...19) }
    end
    it "displays Good morning" do
      visit "/"

      expect(page).to have_text("Good morning!")
    end

    # context "bg selected" do
    #   it "shows the current BG" do
    #     engineer = create :engineer, duty_date: Date.today
    #     visit "/"
    #
    #     expect(page).to have_text("Welcome! The current BG is @#{engineer.slack_username}.")
    #   end
    # end
  end

  context "night" do
    before do
      allow(Time).to receive_message_chain(:zone, :now) do
        now.change hour: Random.rand(19...31) % 24
      end
    end

    it "displays Good night" do
      visit "/"

      expect(page).to have_text("Good night!")
    end
  end
end
