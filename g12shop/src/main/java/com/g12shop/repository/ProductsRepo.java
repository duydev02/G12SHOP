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

	// select * from products where categoryId = ? and discount > ?
	List<Products> findByCategoryIdAndDiscountGreaterThan(Long categoryId, Integer discount);

	//select * from products where isdeleted = ? and quantity > ?
	List<Products> findByIsDeletedAndQuantityGreaterThan(Boolean isDeleted, Integer quantity);

	// Phân trang
	//select * from products where isDeleted = ? and quantity > ?
	Page<Products> findByIsDeletedAndQuantityGreaterThan(Boolean isDeleted, Integer quantity, Pageable pageable);

	//select * from products where productTypes = ? and slug <> ? and isDeleted = ? and quantity > ?
	List<Products> findByProductTypeAndSlugNotAndIsDeletedAndQuantityGreaterThan(ProductTypes productType, String slug,
			Boolean isDeleted, Integer quantity);

	//select * from products where categotyId = ? and isDeleted = ? and quantity > ?
	List<Products> findByCategoryIdAndIsDeletedAndQuantityGreaterThan(Long categoryId, Boolean isDeleted,
			Integer quantity);

	// Phân trang
	//select * from products where categoryId = ? and isDeleted = ? and quantity > ?
	Page<Products> findByCategoryIdAndIsDeletedAndQuantityGreaterThan(Long categoryId, Boolean isDeleted,
			Integer quantity, Pageable pageable);

	@Query(value = "SELECT * FROM products WHERE name LIKE %:key%", nativeQuery = true)
	List<Products> findByKeywords(String key);

	@Query(value = "SELECT * FROM products WHERE name LIKE %:key%", nativeQuery = true)
	Page<Products> findByKeywords(String key, PageRequest of);

}
