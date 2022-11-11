package com.g12shop.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.ProductReviews;

@Repository
public interface ProductReviewsRepo extends JpaRepository<ProductReviews, Long> {

	List<ProductReviews> findAllById(Long id);

	List<ProductReviews> findByProductIdOrderByCreatedDateDesc(Long id);

	@Query(value = "INSERT INTO product_reviews (productId, accountId, [description], createdDate) "
			+ "VALUES (?, ?, ?, GETDATE())", nativeQuery = true)
	@Modifying
    @Transactional
	void createReview(Long productId, Long accountId, String message);

	ProductReviews findTopByAccountIdOrderByCreatedDateDesc(Long accountId);

}
