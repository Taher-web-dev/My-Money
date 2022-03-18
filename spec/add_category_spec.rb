require 'rails_helper'
RSpec.describe 'Add Category page', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.save!
    end
    
  end
  describe 'Add Category page' do
    it 'have right content' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      click_button 'Add a new category'
      expect(page).to have_content('NEW CATEGORY')
      expect(page).to have_content('Add new category')
    end
    it 'Create new category when submit button with correct data' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      click_button 'Add a new category'
      fill_in 'Category Name', with: 'Transportation'
      fill_in 'Icon URL', with: 'data:image/png'
      click_button 'SAVE'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Category saved successfully')
    end
  end
end