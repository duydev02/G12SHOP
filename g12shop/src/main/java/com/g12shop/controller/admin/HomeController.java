package com.g12shop.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.g12shop.service.StatsService;

@Controller(value = "HomeControllerOfAdmin")
@RequestMapping("/admin")
public class HomeController {

	@Autowired
	private StatsService statsService;
	
	@GetMapping("")
	public String doGetIndex(Model model) {
		String[][] chartData = statsService.getTotalPriceAndTotalOrderLast6Months();
		model.addAttribute("chartData", chartData);
		return "admin/index";
	}
}
