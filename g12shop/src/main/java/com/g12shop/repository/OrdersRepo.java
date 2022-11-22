package com.g12shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.Orders;

@Repository
public interface OrdersRepo extends JpaRepository<Orders, Long> {

	List<Orders> findByUserId(Long userId);

	@Query(value = "SELECT * FROM orders ORDER BY CASE "
			+ "WHEN orderStatus = 'CHUA_XAC_NHAN' then 1 "
			+ "WHEN orderStatus = 'DA_XAC_NHAN' then 2 "
			+ "WHEN orderStatus = 'DANG_GIAO_HANG' then 3 "
			+ "WHEN orderStatus = 'DA_GIAO_HANG' then 4 "
			+ "END ASC", nativeQuery = true)
	List<Orders> findByOrderStatusCustom();
}
