package com.g12shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.Products;

@Repository
public interface ProductsRepo extends JpaRepository<Products, Long> {
	List<Products> findByIsDeletedAndQuantityGreaterThan(Boolean isDeleted, Integer quantity);
}
