package com.g12shop.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.g12shop.entity.Orders;
import com.g12shop.service.OrdersService;

@Controller(value = "OrderControllerOfAdmin")
@RequestMapping("/admin/order")
public class OrderController {
	
	@Autowired
	private OrdersService ordersService;

	@GetMapping("")
	public String doGetIndex(Model model) {
		model.addAttribute("isAdminOrderPage", true);
		model.addAttribute("isAdminOrderPage1", true);

		List<Orders> orders = ordersService.findByOrderStatus();
		model.addAttribute("orders", orders);

		return "admin/order";
	}
}
