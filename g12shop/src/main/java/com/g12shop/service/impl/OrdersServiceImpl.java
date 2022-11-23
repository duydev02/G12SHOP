package com.g12shop.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.entity.OrderStatuses;
import com.g12shop.entity.Orders;
import com.g12shop.repository.OrdersRepo;
import com.g12shop.service.OrdersService;

@Service
public class OrdersServiceImpl implements OrdersService {

	@Autowired
	private OrdersRepo repo;

	@Override
	public List<Orders> findAll() {
		return repo.findAll();
	}

	@Override
	public Orders findById(Long id) {
		return repo.findById(id).get();
	}

	@Override
	public List<Orders> findByOrderStatus() {
		return repo.findByOrderStatusCustom();
	}

	@Override
	public List<Orders> findByOrderStatus(OrderStatuses orderStatus) {
		return repo.findByOrderStatus(orderStatus);
	}

	@Override
	public List<Orders> findByOrderByCreatedDateDesc() {
		return repo.findByOrderByCreatedDateDesc();
	}

	@Override
	public Orders insert(Orders order) {
		return repo.saveAndFlush(order);
	}

	@Override
	@Transactional(rollbackOn = { Exception.class, Throwable.class })
	public void updateOrderStatus(Long id, String orderStatus) {
		repo.updateOrderStatus(id, orderStatus);
	}
}
