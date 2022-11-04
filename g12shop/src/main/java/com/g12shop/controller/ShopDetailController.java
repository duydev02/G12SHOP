package com.g12shop.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.g12shop.entity.*;
import com.g12shop.service.AccountsService;
import com.g12shop.service.ProductImagesService;
import com.g12shop.service.ProductReviewsService;
import com.g12shop.service.ProductTypesService;
import com.g12shop.service.ProductsService;

@Controller
@RequestMapping("/")
public class ShopDetailController {
	
	@Autowired
	AccountsService accountsService;
	
	@Autowired
	ProductReviewsService productReviewsService;
	
	@Autowired
	ProductsService productsService;
	
	@Autowired
	ProductImagesService imagesService;
	
	@Autowired
	ProductTypesService productTypesService;
	
    @GetMapping("shop-details/{id}")
    public String doGetShopDetail(Model model, @PathVariable("id") Long id) {
    	Optional<Products> productsid =  productsService.findById(id);
    	List<ProductReviews> productreviews = productReviewsService.findAllByProductId(id);
    	model.addAttribute("productid", productsid.get());
    	model.addAttribute("productrv",productreviews);
        return "shop-details";
    }
}
