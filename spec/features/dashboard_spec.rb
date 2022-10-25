require 'rails_helper'

RSpec.describe 'Dashboard Page' do
    
    it 'can be accessed by authenticated users' do 
        user1 = User.create(name: 'User One', email: 'email1@example.com', password: 'password123')

        visit "/"
    
        click_link "Log In"
    
        fill_in :email, with:'email1@example.com'
        fill_in :password, with: 'password123'
        click_button 'Log In'

        visit '/dashboard'

        expect(page.status_code).to eq(200)
    end 

    it 'can NOT be accessed by a visitor' do 
        visit '/dashboard'

        expect(current_path).to eq('/')
        expect(page).to have_content('You must be a registered user to access this page')
    end 

    
end 