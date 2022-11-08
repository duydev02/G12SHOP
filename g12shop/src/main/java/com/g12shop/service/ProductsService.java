package com.g12shop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;

import com.g12shop.entity.ProductTypes;
import com.g12shop.entity.Products;

public interface ProductsService {

	Optional<Products> findById(Long id);

	Products findBySlug(String slug);

	List<Products> findByDiscount();

	List<Products> findByCategoryIdAndDiscount(Long categoryId);

	List<Products> findAll();
	
	Page<Products> findAll(int pageSize, int pageNumber) throws Exception;

	List<Products> findByRelatedProducts(ProductTypes productType, String slug);

	List<Products> findAllByCategoryId(Long categoryId);
	
	Page<Products> findAllByCategoryId(Long categoryId, int maxSizePage, int pageNumber) throws Exception;

	Page<Products> findByKeywords(String key, int pageSize, int pageNumber) throws Exception;

	List<Products> findByKeywords(String key);

}
