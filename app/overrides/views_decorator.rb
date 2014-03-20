# Override for adding a number_field_tag to all variants on the
# product page
Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "add_multi_add",
                     :replace => "div#product-variants",
                     :partial => "spree/products/cart_with_multi_add")


# Override for only showing the "Add to cart"-button below the multi-add feature.
Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "add_multi_add_button",
                     :remove => "div.add-to-cart erb[loud]:contains('number_field_tag')")
