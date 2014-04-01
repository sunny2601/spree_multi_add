require "spec_helper"

feature "Add multiple variants to cart", js: true do

  scenario "Product page should have three variants with quantity set to zero" do
    product = create(:product, :variants => [create(:variant), create(:variant), create(:variant)])

    visit spree.product_path(product)
    page.should have_selector("div#product-variants li", :count => 3)
    
    # Default value should be zero (chosen products)
    page.should have_selector("#product-variants input[value='0']", :count => 3)
  end
  
  scenario "Buy multiple variants of a product" do
    
    product = create(:product, :variants => [create(:variant), create(:variant), create(:variant)])
    visit spree.product_path(product)
    
    within("#product-variants") do
      fill_in "variants_#{product.variants.first.id}", :with => "10"
      fill_in "variants_#{product.variants.last.id}", :with => "20"
    end

    within("div.add-to-cart") do
      click_button("Add To Cart")
    end

    # Verify that we are on the correct page
    page.should have_content("Shopping Cart")


    # Should have 1 product but with two different variants
    within("#cart-detail") do
      page.should have_selector("tr.line-item", :count => 2)
    end

    # Verify quantity
    within("#cart-detail") do
      page.should have_selector("input[value='10']", :count => 1)
      page.should have_selector("input[value='20']", :count => 1)
    end

  end


  scenario "Single product with no variants should have one quantity fields set to zero" do

    product = create(:product)
    visit spree.product_path(product)

    # Default value should be zero (chosen products)
    page.should have_selector("div.add-to-cart input[value='0']", :count => 1)
  end


  scenario "Buy product with no variants" do

    product = create(:product)
    visit spree.product_path(product)

    within("div.add-to-cart") do
      fill_in "variants_#{product.master.id}", :with => "10"
      click_button("Add To Cart")
    end

    # Verify that we are on the correct page
    page.should have_content("Shopping Cart")

    # Should have 1 product but with two different variants
    within("#cart-detail") do
      page.should have_selector("tr.line-item", :count => 1)
    end

    # Verify quantity
    within("#cart-detail") do
      page.should have_selector("input[value='10']", :count => 1)
    end

  end

  # For bug #1
  scenario "Product page should show first variants image" do

    image1 = File.open(File.expand_path('../../../fixtures/1.jpg', __FILE__))
    image2 = File.open(File.expand_path('../../../fixtures/2.jpg', __FILE__))
    product = create(:product, :variants => [create(:variant), create(:variant),create(:variant)])
    product.variants.first.images.create!(:attachment => image1)
    product.variants.last.images.create!(:attachment => image2)


    visit spree.product_path(product)

    within("#main-image") do
      filename = product.variants.first.images.first.attachment_file_name
      page.should have_xpath("//img[contains(@src, '#{filename}')]")
    end

    within("#product-variants") do
      find("#variants_#{product.variants.last.id}").click

      filename = product.variants.last.images.first.attachment_file_name
      page.should have_xpath("//img[contains(@src, '#{filename}')]")
    end

  end

end
