require 'rails_helper'

feature "User visits homepage of website" do
  scenario "successfully" do
    visit root_path

    expect(page).to have_css 'h1', text: 'Shoutr'
  end
end
