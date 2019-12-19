require 'rails_helper'

RSpec.feature "Books", js: true, type: :feature do
	before(:each) do
    create(:author)
    create(:book)
  end
  scenario 'Create a new book' do
  	visit "books/new"
 		fill_in 'Title', with: 'Ruby on rails'
    find(:xpath , '//*[@id="book_author_ids_"]').set(true)
		click_button 'Save Book'
		expect(page).to have_text("Book created successfully.")
  end

  scenario 'Should not create book' do
  	visit "books/new"
  	find(:xpath , '//*[@id="book_author_ids_"]').set(true)
		click_button 'Save Book'
		expect(page).to have_text("Title can't be blank")
  end

  scenario 'Should display all the available books' do
  	visit "books"
  end

  scenario 'Should diplay a particular book' do
  	visit "books"
  	click_link 'Show'
  end

  scenario 'Should delete a particular book' do
  	visit "books"
  	click_link 'Delete'
  	page.driver.browser.switch_to.alert.accept
  end
end