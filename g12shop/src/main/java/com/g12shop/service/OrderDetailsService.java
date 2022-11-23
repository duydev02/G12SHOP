package com.g12shop.service;

import java.util.List;

import com.g12shop.dto.CartDetailDto;
import com.g12shop.entity.OrderDetails;

public interface OrderDetailsService {

	List<OrderDetails> findByOrderId(Long id);

	void insert(CartDetailDto cartDetailDto);
}
