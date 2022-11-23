package com.g12shop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.dto.CartDetailDto;
import com.g12shop.entity.OrderDetails;
import com.g12shop.repository.OrderDetailsRepo;
import com.g12shop.service.OrderDetailsService;

@Service
public class OrderDetailsServiceImpl implements OrderDetailsService {

	@Autowired
	private OrderDetailsRepo repo;

	@Override
	public List<OrderDetails> findByOrderId(Long id) {
		return repo.findByOrderId(id);
	}
	
	@Override
	public void insert(CartDetailDto cartDetailDto) {
		Double percentDiscount = 1.0;
		if (cartDetailDto.getDiscount() != null) {
			Double discount = (double) cartDetailDto.getDiscount();
			if (discount > 0) {
				percentDiscount = 1.0 - discount / 100;
			}
		}
		Double price = cartDetailDto.getPrice() * percentDiscount;
		cartDetailDto.setPrice(price);
		repo.insert(cartDetailDto);
	}

}
