package com.g12shop.service;

import com.g12shop.dto.CartDto;
import com.g12shop.entity.Accounts;

public interface CartService {
	
	CartDto updateCart(CartDto cart, Long productId, Integer quantity, boolean isReplace);
	Integer getTotalQuantity(CartDto cart);
	Double getTotalPrice(CartDto cart);
	void insert(CartDto cart, Accounts account, String address, String phone) throws Exception;
}
