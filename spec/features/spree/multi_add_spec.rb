require "spec_helper"


describe "Adding multiple variants to cart on product page", js: true do

  context "Products with multiple variants" do

    let(:product) { 
      create(:product, :variants => [create(:variant), create(:variant), create(:variant)])
    }

    it "should have three variants with quantity set to zero on" do

      visit spree.product_path(product)
      page.should have_selector("div#product-variants li", :count => 3)

      # Default value should be zero (chosen products)
      page.should have_selector("#product-variants input[value='0']", :count => 3)
    end

    
    it "should add multiple variants with different quantities to the cart" do

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
    end

    # Regression test for #1
    context "main-image should show variant images" do

      before do

        image1 = File.open(File.expand_path('../../../fixtures/1.jpg', __FILE__))
        image2 = File.open(File.expand_path('../../../fixtures/2.jpg', __FILE__))
        product.variants.first.images.create!(:attachment => image1)
        product.variants.last.images.create!(:attachment => image2)

      end


      it "should show first variant image as default" do

        visit spree.product_path(product)

        within("#main-image") do
          filename = product.variants.first.images.first.attachment_file_name
          page.should have_xpath("//img[contains(@src, '#{filename}')]")
        end

      end

      it "should change main-image after click on input-elements" do

        visit spree.product_path(product)

        within("#product-variants") do
          find("#variants_#{product.variants.last.id}").click

          filename = product.variants.last.images.first.attachment_file_name
          page.should have_xpath("//img[contains(@src, '#{filename}')]")
        end

      end

    end

  end


  context "Products with no variants (excluding the master variant)" do
    
    it "should have only one input-element and it should be set to zero" do

      product = create(:product)
      visit spree.product_path(product)

      # Default value should be zero (chosen products)
      page.should have_selector("div.add-to-cart input[value='0']", :count => 1)
    end

    it "should add a single product to the cart" do

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

  end

end
