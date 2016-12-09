require 'rails_helper'

describe "main page", :type => :feature do
  it "displays Hello, world!" do
    visit "/"

    expect(page).to have_text("Hello, world!")
  end
end
