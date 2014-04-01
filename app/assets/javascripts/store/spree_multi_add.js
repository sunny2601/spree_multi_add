//= require store/spree_frontend

(function() {
	$(function() {

		inputs = $('#product-variants input[type="number"]');

		// Use the first variant as default variant.
		if (inputs.length > 0) {
			default_variant_to_show = inputs.first().attr("name").match(/\d+/)[0]

			Spree.showVariantImages(default_variant_to_show);
			Spree.updateVariantPrice(inputs.first());
		}

		Spree.addImageHandlers();

		// Create clickhandlers for inputs so they update show the correct variant image
		return inputs.click(function(event) {

			Spree.showVariantImages($(this).attr("name").match(/\d+/)[0]);
			return Spree.updateVariantPrice($(this));
		});


	});

}).call(this);
