require 'rails_helper'

describe "main page", :type => :feature do

  let!(:now) { Time.now }
  context "morning" do
    before { allow(Time).to receive(:now) { now.change hour: Random.rand(0...12) } }
    it "displays Good morning" do
      visit "/"

      expect(page).to have_text("Good morning!")
    end

    context "bg selected" do
      it "shows the current BG" do
        engineer = create :engineer, duty_date: Date.today
        visit "/"

        expect(page).to have_text("Welcome! The current BG is @#{engineer.slack_username}.")
      end
    end

    context "bg not selected" do
      let!(:past_bgs) do
        past_bgs = []
        num_of_past_bgs = Random.rand 0..3
        num_of_past_bgs.times do |i|
          past_bgs << create(
            :engineer,
            duty_date: Faker::Date.between(100.days.ago, 1.days.ago),
            duty_fulfilled: true
          )
        end
        past_bgs
      end
      let!(:available_engineers) { create_list :engineer, Random.rand(4..8) }

      it "shows list of available BGs" do
        visit "/"
        available_engineers.each do |engineer|
          expect(page).to have_text("@#{engineer.slack_username}")
        end
        past_bgs.each do |engineer|
          expect(page).not_to have_text("@#{engineer.slack_username}")
        end
        expect(page).to have_button("Roll the Dice and Select BG!")
      end

      it "select a BG randomly from available engineers if button clicked" do
        visit "/"
        click_button "Roll the Dice and Select BG!"

        selected_bg = Engineer.where(duty_date: Date.today).first
        expect(page).to have_text("Welcome! The current BG is @#{selected_bg.slack_username}")
      end

      it "never select an engineer as BG if specifically excluded" do
        num_of_excluded = Random.rand 1..3
        excluded_engineers = available_engineers.sample num_of_excluded

        visit "/"
        excluded_engineers.each do |excluded_engineer|
          check "excluded[#{excluded_engineer.id}]"
        end
        click_button "Roll the Dice and Select BG!"

        selected_bg = Engineer.where(duty_date: Date.today).first
        excluded_engineers.each do |excluded_engineer|
          expect(selected_bg.id).not_to eq(excluded_engineer.id)
        end
      end
    end
  end

  context "night" do
    before { allow(Time).to receive(:now) { now.change hour: Random.rand(12...24) } }

    it "displays Good night" do
      visit "/"

      expect(page).to have_text("Good night!")
    end
  end
end
