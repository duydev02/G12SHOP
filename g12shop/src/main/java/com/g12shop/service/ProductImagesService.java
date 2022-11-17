package com.g12shop.service;

import java.util.List;
import java.util.Optional;

import com.g12shop.entity.ProductImages;

public interface ProductImagesService {

	Optional<ProductImages> findById(Long id);

	List<ProductImages> findByProductId(Long id);

}
