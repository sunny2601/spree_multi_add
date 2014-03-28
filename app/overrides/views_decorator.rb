# Override for adding a number_field_tag to all variants on the
# product page
Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "add_multi_add",
                     :replace => "div#product-variants",
                     :partial => "spree/products/cart_with_multi_add")



# Override for showing the quantity field at the "Add to cart"-button when there are no variants
Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "hide_quantity_field",
                     :replace => "div.add-to-cart",
                     :partial => "spree/products/add_to_cart")
