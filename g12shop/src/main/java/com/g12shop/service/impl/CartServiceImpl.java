package com.g12shop.service.impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.dto.CartDetailDto;
import com.g12shop.dto.CartDto;
import com.g12shop.entity.Products;
import com.g12shop.service.CartService;
import com.g12shop.service.ProductsService;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private ProductsService productsService;

	@Override
	public CartDto updateCart(CartDto cart, Long productId, Integer quantity, boolean isReplace) {
		Products product = productsService.findById(productId);

		HashMap<Long, CartDetailDto> details = cart.getDetails();

		// 1 - them moi sp
		// 2 - update:
		// 2.1 - cong don
		// 2.2 - replace
		// 3 - delete: update quantity ve 0

		if (!details.containsKey(productId)) {
			// them moi
			CartDetailDto newDetail = createNewCartDetail(product, quantity);
			details.put(productId, newDetail);
		} else if (quantity > 0) {
			// update
			if (isReplace) {
				// thay the
				details.get(productId).setQuantity(quantity);
			} else {
				// cong don
				Integer oldQuantity = details.get(productId).getQuantity();
				Integer newQuantity = oldQuantity + quantity;
				details.get(productId).setQuantity(newQuantity);
			}
		} else {
			// delete
			details.remove(productId);
		}
		cart.setTotalQuantity(getTotalQuantity(cart));
		cart.setTotalPrice(getTotalPrice(cart));
		return cart;
	}

	@Override
	public Integer getTotalQuantity(CartDto cart) {
		Integer totalQuantity = 0;
		HashMap<Long, CartDetailDto> details = cart.getDetails();
		for (CartDetailDto cartDetail : details.values()) {
			totalQuantity += cartDetail.getQuantity();
		}
		return totalQuantity;
	}

	@Override
	public Double getTotalPrice(CartDto cart) {
		Double totalPrice = 0D;
		HashMap<Long, CartDetailDto> details = cart.getDetails();
		for (CartDetailDto cartDetail : details.values()) {

			Double percentDiscount = 1.0;
			if (cartDetail.getDiscount() != null) {
				Double discount = (double) cartDetail.getDiscount();
				if (discount > 0) {
					percentDiscount = 1.0 - discount / 100;
				}
			}
			totalPrice += cartDetail.getPrice() * percentDiscount * cartDetail.getQuantity();
		}
		return totalPrice;
	}

	private CartDetailDto createNewCartDetail(Products product, Integer quantity) {
		CartDetailDto cartDetail = new CartDetailDto();
		cartDetail.setProductId(product.getId());
		cartDetail.setPrice(product.getPrice());
		cartDetail.setDiscount(product.getDiscount());
		cartDetail.setQuantity(quantity);
		cartDetail.setSlug(product.getSlug());
		cartDetail.setName(product.getName());
		cartDetail.setImgName(product.getImgName());
		return cartDetail;
	}

}
