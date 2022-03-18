require 'rails_helper'
RSpec.describe 'Expense page', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.save!
    end
    
  end
  describe 'Expense page' do
    
    it 'have right content' do
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
      click_link('Food')
      expect(page).to have_content('TRANSACTIONS')
      expect(page).to have_content('ADD A NEW TRANSACTION')
      expect(page).to have_content('Total amount')
      expect(page).to have_content('Most recent')
    end
    it 'Display data for concerned transactions' do
        unless Category.all.length >=1
            new_user = User.find_by(email: 'test@gmail.com')
            new_category = Category.new(name: 'Food', icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmk7E-ji43uI4gdQcYpGO1LLeFFcZ8m9NOTw&usqp=CAU',user: new_user)
            new_category.save!
          end
          unless Expense.find_by(name:'restaurant')
            new_user = User.find_by(email: 'test@gmail.com')
            new_transaction = Expense.new(name: 'restaurant', user: new_user, amount: 25)
            new_transaction.save!
            
          end
          unless OperationType.all.length >= 1
            new_category = Category.find_by(name: 'Food')
            transaction = Expense.find_by(name: 'restaurant')
            transaction.create_category_type([new_category.id])
          end
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      click_link('Food')
      expect(page).to have_content('restaurant')
      expect(page).to have_content('$25.0')
    end
    it 'When the user clicks on the "Back" button (<), the user navigates to the home page.' do
      
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      click_link('Food')
      click_link('back')
      expect(page).to have_current_path(root_path)
    end
   
  end
end