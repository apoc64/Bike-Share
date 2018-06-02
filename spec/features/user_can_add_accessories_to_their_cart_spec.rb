require 'rails_helper'

describe 'as a visitor' do
  describe 'when I visit /bike-shop' do
    describe 'when I click on Add to cart' do
      it 'adds a accessory to the cart' do
        accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')

        visit '/bike-shop'

        click_on 'Add to cart'

        expect(page).to have_content("You now have 1 #{accessory.title} in your cart.")
        expect(current_path).to eq('/bike-shop')
      end

      scenario "the message correctly increments for multiple accessories" do
        accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')
        visit '/bike-shop'

        click_button "Add to cart"

        expect(page).to have_content("You now have 1 #{accessory.title} in your cart.")

        click_button "Add to cart"

        expect(page).to have_content("You now have 2 #{accessory.title}es in your cart.")
      end

      scenario "the total number of accessories in the cart increments" do

        accessory = Accessory.create!(title: 'wranch', image: 'http://blog.zealousgood.com/wp-content/uploads/2013/05/tools.jpg', price: 100, description: 'this is tool')
        visit '/bike-shop'

        expect(page).to have_content("Cart: 0")

        click_button "Add to cart"

        expect(page).to have_content("Cart: 1")
      end
    end
  end
end
