require "spec_helper"

feature "Add multiple variants to cart", js: true do

  #scenario "Product page should have multiple number input fields" do
  scenario "Product page should have three variants" do
    product = create(:product, :variants => [create(:variant), create(:variant), create(:variant)])

    visit spree.product_path(product)
    page.should have_selector("div#product-variants li", :count => 3)
    
    # Default value should be zero (chosen products)
    #page.should have_selector("div#product-variants input[value='0']", :count => 3)

    require 'pry'; binding.pry

    page.should have_selector("#product-variants input[value='0']", :count => 3)

  end
  


end

  #it { should_not have_selector('li.cmgr-active a[href="' + list_parts_path + '"]') }
