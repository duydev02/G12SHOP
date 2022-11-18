package com.g12shop.controller.admin;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.entity.Categories;
import com.g12shop.entity.ProductTypes;
import com.g12shop.entity.Products;
import com.g12shop.service.CategoriesService;
import com.g12shop.service.ProductTypesService;
import com.g12shop.service.ProductsService;

@Controller(value = "ProductControllerOfAdmin")
@RequestMapping("/admin/product")
public class ProductController {

	@Autowired
	private ProductsService productsService;

	@Autowired
	private CategoriesService categoriesService;

	@Autowired
	private ProductTypesService productTypesService;

	@GetMapping("")
	public String doGetIndex(Model model) {
		model.addAttribute("isAdminProductPage", true);
		model.addAttribute("isAdminProductPage1", true);

		List<Products> products = productsService.findAll();
		model.addAttribute("products", products);

		List<Categories> categories = categoriesService.findAll();
		model.addAttribute("categories", categories);

		List<ProductTypes> productTypes = productTypesService.findAll();
		model.addAttribute("productTypes", productTypes);

		model.addAttribute("productRequest", new Products());
		return "admin/product";
	}

	// /admin/product/delete?id={...}
	@GetMapping("/delete")
	public String doGetDelete(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
		try {
			productsService.deleteLogical(id);
			redirectAttributes.addFlashAttribute("succeedMessage", "Product " + id + " has been deleted");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "Cannot create product " + id);
		}
		return "redirect:/admin/product";
	}
	
	@PostMapping("/create")
	public String doPostCreateProduct(@Valid @ModelAttribute("productRequest") Products productRequest, BindingResult bindingResult,
			RedirectAttributes redirectAttributes, @RequestParam("productTypes") Long productType,
			@RequestParam("brandTypes") Long brandType, @RequestParam("unitTypes") Long unitType,
			@RequestParam("attach") MultipartFile attach) {
		if (bindingResult.hasErrors()) {
			redirectAttributes.addFlashAttribute("errorMessage", "Product is not valid");
		} else {
			try {
				if (!attach.isEmpty()) {
					Path path = Paths.get("target/classes/static/user/img/product/");

					if (!Files.exists(path)) {
						Files.createDirectories(path);
					}

					InputStream inputStream = attach.getInputStream();
					Files.copy(inputStream, path.resolve(attach.getOriginalFilename()),
							StandardCopyOption.REPLACE_EXISTING);
					productRequest.setImgName(attach.getOriginalFilename());
				}
				productsService.save(productRequest, productType, brandType, unitType);
				redirectAttributes.addFlashAttribute("succeedMessage",
						"Product " + productRequest.getName() + " has been created successfully");
			} catch (Exception e) {
				e.printStackTrace();
				redirectAttributes.addFlashAttribute("succeedMessage",
						"Cannot create product: " + productRequest.getName());
			}
		}
		return "redirect:/admin/product";
	}
}
