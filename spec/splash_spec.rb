require 'rails_helper'
RSpec.describe 'Splash page', type: :system do
  describe 'Splash page' do
    it 'shows the name of my application' do
      visit root_path
      expect(page).to have_content('My Money')
    end
    it 'it has links to sign in page' do
      visit root_path
      expect(page).to have_content('SIGN IN')
      click_button('SIGN IN')
      expect(page).to have_current_path(new_user_session_path)
    end
    it 'it has links to sign up page' do
      visit root_path
      expect(page).to have_content('SIGN UP')
      click_button('SIGN UP')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
