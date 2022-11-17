package com.g12shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.g12shop.entity.Users;

@Repository
public interface UsersRepo extends JpaRepository<Users, Long> {
	
	List<Users> findByIsDeleted(Boolean isDeleted);
	
	Users findByUsername(String username);
	
	Users findByEmail(String email);
	
	//login
	Users findByUsernameOrEmailAndIsEnabledAndIsDeleted(String username, String email, Boolean isEnabled, Boolean isDeleted);
	Users findByVerificationCode(String verificationCode);
	
	//Take token 
	Users findByResetPasswordToken(String token);
	
	@Modifying(clearAutomatically = true)
	@Query(value = "UPDATE users SET isDeleted = 1 WHERE username = ?", nativeQuery = true)
	void deleteLogical(String username);
}
