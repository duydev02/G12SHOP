package com.g12shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.Accounts;

@Repository
public interface AccountsRepo extends JpaRepository<Accounts, Long> {
	
	Accounts findByUsername(String username);
	Accounts findByEmail(String email);
	
	//login
	Accounts findByUsernameOrEmailAndIsEnabledAndIsDeleted(String username, String email, Boolean isEnabled, Boolean isDeleted);
	
	
}
