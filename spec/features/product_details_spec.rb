require 'rails_helper'

RSpec.feature "Vistor clicks on product to view product details", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product desciption" do
    visit root_path

    find('a-btn-default').clicks
    
    expect(page).to have_content('Description')

    save_screenshot
  end
end
