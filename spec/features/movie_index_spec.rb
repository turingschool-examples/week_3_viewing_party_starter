require 'rails_helper'

RSpec.describe 'Movies Index Page' do
    before do 
        i = 1
        20.times do 
            Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
            i+=1
        end 
    end 

    it 'shows all movies' do 
        user1 = User.create(name: 'User One', email: 'email1@example.com', password: 'password123')

        visit "/"
    
        click_link "Log In"
    
        fill_in :email, with:'email1@example.com'
        fill_in :password, with: 'password123'
        click_button 'Log In'

        visit '/dashboard'

        click_button "Find Top Rated Movies"

        expect(current_path).to eq("/movies")

        expect(page).to have_content("Top Rated Movies")

        Movie.all.each do |movie|
            within("#movie-#{movie.id}") do 
                expect(page).to have_link(movie.title)
                expect(page).to have_content("Rating: #{movie.rating}/10")
            end 
        end 
    end 
end