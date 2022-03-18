require 'rails_helper'
RSpec.describe 'Home page', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.save!
    end
    
  end
  describe 'home page' do
    
    it 'have right content' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content('CATEGORIES')
      expect(page).to have_content('ADD A NEW CATEGORY')
      expect(page).to have_content('No category created yet!')  
    end
    it 'have button which can allow bring user to the page to craete new category' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      click_button 'Add a new category'
      expect(page).to have_current_path(new_category_path)
    end
    it 'display category with required information' do
      unless Category.all.length >=1
        new_user = User.find_by(email: 'test@gmail.com')
        new_category = Category.new(name: 'Food', icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmk7E-ji43uI4gdQcYpGO1LLeFFcZ8m9NOTw&usqp=CAU',user: new_user)
        new_category.save!
      end
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content('Food')
      expect(page).to have_content('$0')
      expect(page).to have_css("img[src*='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmk7E-ji43uI4gdQcYpGO1LLeFFcZ8m9NOTw&usqp=CAU']")
    end
    it 'navigate to the transaction page when the user tape on a category item' do
      unless Category.all.length >=1
        new_user = User.find_by(email: 'test@gmail.com')
        new_category = Category.new(name: 'Food', icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmk7E-ji43uI4gdQcYpGO1LLeFFcZ8m9NOTw&usqp=CAU',user: new_user)
        new_category.save!
      end
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      id = Category.find_by(name: 'Food').id
      click_button 'Log in'
      click_link('Food')
      expect(page).to have_current_path("/expenses/#{id}")
    end
  end
end