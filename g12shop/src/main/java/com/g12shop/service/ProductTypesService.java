package com.g12shop.service;

import java.util.List;
import java.util.Optional;

import com.g12shop.entity.ProductTypes;

public interface ProductTypesService {
	List<ProductTypes> findAll();

	Optional<ProductTypes> findById(Long id);
}
