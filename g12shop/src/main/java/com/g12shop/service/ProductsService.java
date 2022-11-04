package com.g12shop.service;

import java.util.List;
import java.util.Optional;

import com.g12shop.entity.Products;

public interface ProductsService {
	List<Products> findAll();

	Optional<Products> findById(Long id);
}
