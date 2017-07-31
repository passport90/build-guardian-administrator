require 'rails_helper'

describe "main page", :type => :feature do

  let!(:now) { Time.now }
  let!(:today) { Date.today }
  before { allow(today).to receive(:wday) { Random.rand(1..5) }  }
  before { allow(Date).to receive(:today) { today }  }
  context "morning" do
    before { allow(Time).to receive(:now) { now.change hour: Random.rand(0...12) } }
    it "displays Good day" do
      visit "/"

      expect(page).to have_text("Good day!")
    end

    context "bg selected" do
      it "shows the current BG" do
        engineer = create :engineer, duty_date: Date.today
        visit "/"

        expect(page).to have_text("Welcome! The current BG is @#{engineer.slack_username}.")
      end
    end

    context "bg not selected" do
      context "not authenticated" do
        it "asks for password" do
          visit "/"

          expect(page).to have_text("Enter the password")
          expect(page).to have_button("Login")
        end
      end

      context "authenticated" do
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
        let!(:duty_debtor) { create :engineer, duty_owed: true }
        let!(:available_engineers) { create_list :engineer, Random.rand(4..8) }
        before do
          visit "/"
          fill_in "login[password]", with: "queenjaneapproximately"
          click_button "Login"
        end

        it "shows list of available BGs" do
          visit "/"
          available_engineers.each do |engineer|
            expect(page).to have_text("@#{engineer.slack_username}")
          end
          past_bgs.each do |engineer|
            expect(page).not_to have_text("@#{engineer.slack_username}")
          end
          expect(page).to have_button("Roll the Dice and Select BG!")
          expect(page).to have_button("Begin New Round")
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

        it "set all past bgs as available after begining new round" do
          visit "/"

          click_button "Begin New Round"
          available_engineers.each do |engineer|
            expect(page).to have_text("@#{engineer.slack_username}")
          end
          past_bgs.each do |engineer|
            expect(page).to have_text("@#{engineer.slack_username}")
          end
        end

        it "shows the duty debtor" do
          visit "/"

          expect(page).to have_text("@#{duty_debtor.slack_username} has not finished a BG duty.")
          expect(page).to have_button("Select @#{duty_debtor.slack_username} as BG")
        end

        it "could select duty debtor as BG" do
          visit "/"

          click_button "Select @#{duty_debtor.slack_username} as BG"

          expect(page).to have_text("Welcome! The current BG is @#{duty_debtor.slack_username}")
        end

        context "there is no BG available" do
          let!(:available_engineers) { [] }
          it "does not list available BG and there is no roll dice button" do
            visit "/"

            expect(page).to have_text("There is no more available engineers.")
            expect(page).not_to have_button("Roll the Dice and Select BG!")
          end
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

    context "day has not been concluded" do
      let!(:current_bg) { create :engineer, duty_date: Date.today }
      context "not authenticated" do
        it "asks for password" do
          visit "/"

          expect(page).to have_text("Enter the password")
          expect(page).to have_button("Login")
        end
      end

      context "authenticated" do
        before do
          visit "/"
          fill_in "login[password]", with: "queenjaneapproximately"
          click_button "Login"
        end

        it "displays conclusion form" do
          visit "/"
          expect(page).to have_text("Has @#{current_bg.slack_username} successfully finish the duty?")
          expect(page).to have_button("Yes")
          expect(page).to have_button("No")
        end

        context "bg has successfully finish the duty" do
          it "set duty_fulfilled to true and conclude the day" do
            visit "/"
            click_button "Yes"
            expect(page).to have_text(
              "@#{current_bg.slack_username} has successfully finished the duty."
            )
          end
        end

        context "bg has not successfully finish the duty" do
          it "set duty_owed to true and conclude the day" do
            visit "/"
            click_button "No"
            expect(page).to have_text(
              "@#{current_bg.slack_username} has failed to finish the duty\
              and will be BG again this round."
            )
          end
        end
      end
    end
  end

  context "weekend" do
    before { allow(today).to receive(:wday) { Random.rand(0..1) == 0 ? 0 : 6 }  }
    it "Shows happy weekend and does not show anything related to BG" do
      visit "/"

      expect(page).to have_text("Happy weekend!")
      expect(page).not_to have_text("Welcome! The current BG is @")
      expect(page).not_to have_button("Roll the Dice and Select BG!")
      expect(page).not_to have_button("Begin New Round")
      expect(page).not_to have_text("finish the duty")
    end
  end
end
