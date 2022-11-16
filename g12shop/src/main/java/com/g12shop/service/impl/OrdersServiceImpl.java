package com.g12shop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.entity.Orders;
import com.g12shop.repository.OrdersRepo;
import com.g12shop.service.OrdersService;

@Service
public class OrdersServiceImpl implements OrdersService {
	
	@Autowired
	private OrdersRepo repo;

	@Override
	public Orders insert(Orders order) {
		return repo.saveAndFlush(order);
	}

}
