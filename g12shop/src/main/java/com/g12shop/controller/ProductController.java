package com.g12shop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.g12shop.entity.Categories;
import com.g12shop.entity.ProductReviews;
import com.g12shop.entity.Products;
import com.g12shop.service.CategoriesService;
import com.g12shop.service.ProductReviewsService;
import com.g12shop.service.ProductsService;

@Controller
@RequestMapping("/")
public class ProductController {

	@Autowired
	ProductReviewsService productReviewsService;

	@Autowired
	ProductsService productsService;
	
	@Autowired
	CategoriesService categoriesService;

	private static final int PAGE_SIZE = 9;

	@GetMapping("shop-grid")
	public String doGetShopGrid(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			Model model) {
		model.addAttribute("isShopPage", true);
		List<Products> products = new ArrayList<>();
		try {
			Page<Products> pageProducts = productsService.findAll(PAGE_SIZE, page);
			products = pageProducts.getContent();
			model.addAttribute("totalPages", pageProducts.getTotalPages());
			model.addAttribute("currentPage", page);
		} catch (Exception e) {
			products = productsService.findAll();
		}
		model.addAttribute("products", products);
		model.addAttribute("totalProducts", productsService.findAll().size());
		List<Products> discountProducts = productsService.findByDiscount();
		model.addAttribute("discountProducts", discountProducts);
		return "shop-grid";
	}

	@GetMapping("shop-grid/{slug}")
	public String doGetShopGridByCategory(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@PathVariable("slug") String categorySlug, Model model) {
		model.addAttribute("isShopPage", true);
		Categories category = categoriesService.findBySlug(categorySlug);
		if (categoriesService.findBySlug(categorySlug) == null) {
			return "not-found";
		}
		Long categoryId = category.getId();
		List<Products> products = new ArrayList<>();
		try {
			Page<Products> pageProducts = productsService.findAllByCategoryId(categoryId, PAGE_SIZE, page);
			products = pageProducts.getContent();
			model.addAttribute("totalPages", pageProducts.getTotalPages());
			model.addAttribute("currentPage", page);
		} catch (Exception e) {
			products = productsService.findAllByCategoryId(categoryId);
		}
		model.addAttribute("products", products);
		System.out.println(products);
		model.addAttribute("totalProducts", productsService.findAllByCategoryId(categoryId).size());
		List<Products> discountProducts = productsService.findByCategoryIdAndDiscount(categoryId);
		model.addAttribute("discountProducts", discountProducts);
		return "shop-grid";
	}

	@GetMapping("shop-details/{slug}")
	public String doGetShopDetail(@PathVariable("slug") String slug, Model model) {
		Products product = productsService.findBySlug(slug);
		if (product == null) {
			return "not-found";
		}
		System.out.println(product);
		List<ProductReviews> productReviews = productReviewsService.findAllByProductId(product.getId());
		List<Products> relatedProducts = productsService.findByRelatedProducts(product.getProductType(), slug);
		model.addAttribute("product", product);
		model.addAttribute("productReviews", productReviews);
		model.addAttribute("relatedProducts", relatedProducts);
		return "shop-details";
	}
	
	@GetMapping("/search")
	public String search(@RequestParam("key") String key,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model,
			HttpSession session) {
		List<Products> products = new ArrayList<>();
		try {
			Page<Products> pageProducts = productsService.findByKeywords(key, PAGE_SIZE, page);
			products = pageProducts.getContent();
			model.addAttribute("totalProducts", productsService.findByKeywords(key).size());
			model.addAttribute("totalPages", pageProducts.getTotalPages());
			model.addAttribute("currentPage", page);
		} catch (Exception e) {
			products = productsService.findAll();
		}
		model.addAttribute("isSearched", Boolean.TRUE);
		model.addAttribute("products", products);
		return "shop-grid";
	}
}
