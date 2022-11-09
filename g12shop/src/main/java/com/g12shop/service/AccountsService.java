package com.g12shop.service;

import java.util.List;

import com.g12shop.entity.Accounts;
import com.g12shop.Util.UserNotFoundExcepion;

public interface AccountsService {

	List<Accounts> findAll();

	//Đăng nhập
	Accounts doLogin(String usernameOrEmail, String password) throws UserNotFoundExcepion;
	
	//Đăng kí
	Accounts doRegister(Accounts account) throws UserNotFoundExcepion;
	//Send mail verification
	void sendVerificationEmail(Accounts account, String siteURL) throws Exception;
	//verification
	Boolean verificationAccount(String verificationCode);
}
