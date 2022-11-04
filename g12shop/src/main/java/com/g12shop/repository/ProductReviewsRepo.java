package com.g12shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.ProductReviews;

@Repository
public interface ProductReviewsRepo extends JpaRepository<ProductReviews, Long> {

	List<ProductReviews> findAllById(Long id);

	List<ProductReviews> findAllByProductId(Long id);

}
