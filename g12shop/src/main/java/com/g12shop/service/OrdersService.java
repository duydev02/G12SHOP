package com.g12shop.service;

import java.util.List;

import com.g12shop.entity.Orders;

public interface OrdersService {

	List<Orders> findAll();

	Orders findById(Long id);

	List<Orders> findByOrderStatus();

	Orders insert(Orders order);
}
