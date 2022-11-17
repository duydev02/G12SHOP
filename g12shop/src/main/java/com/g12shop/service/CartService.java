package com.g12shop.service;

import com.g12shop.dto.CartDto;
import com.g12shop.entity.Users;

public interface CartService {
	
	CartDto updateCart(CartDto cart, Long productId, Integer quantity, boolean isReplace);
	Integer getTotalQuantity(CartDto cart);
	Double getTotalPrice(CartDto cart);
	void insert(CartDto cart, Users user, String address, String phone) throws Exception;
}
