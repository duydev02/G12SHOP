package com.g12shop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.ProductTypes;
import com.g12shop.entity.Products;

@Repository
public interface ProductsRepo extends JpaRepository<Products, Long> {

	Products findBySlug(String slug);

	List<Products> findByDiscountGreaterThan(Integer discount);

	List<Products> findByCategoryIdAndDiscountGreaterThan(Long categoryId, Integer discount);

	List<Products> findByIsDeletedAndQuantityGreaterThan(Boolean isDeleted, Integer quantity);

	// Phân trang
	Page<Products> findByIsDeletedAndQuantityGreaterThan(Boolean isDeleted, Integer quantity, Pageable pageable);

	List<Products> findByProductTypeAndSlugNotAndIsDeletedAndQuantityGreaterThan(ProductTypes productType, String slug,
			Boolean isDeleted, Integer quantity);

	List<Products> findByCategoryIdAndIsDeletedAndQuantityGreaterThan(Long categoryId, Boolean isDeleted,
			Integer quantity);

	// Phân trang
	Page<Products> findByCategoryIdAndIsDeletedAndQuantityGreaterThan(Long categoryId, Boolean isDeleted,
			Integer quantity, Pageable pageable);

	@Query(value = "SELECT * FROM products WHERE name LIKE %:key%", nativeQuery = true)
	List<Products> findByKeywords(String key);

	@Query(value = "SELECT * FROM products WHERE name LIKE %:key%", nativeQuery = true)
	Page<Products> findByKeywords(String key, PageRequest of);

}
