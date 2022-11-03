package com.g12shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.g12shop.entity.ProductTypes;

public interface ProductTypesRepo extends JpaRepository<ProductTypes, Long> {
	
	List<ProductTypes> findByIsDeleted(Boolean isDeleted);

}
