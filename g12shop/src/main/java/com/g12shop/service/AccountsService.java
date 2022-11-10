package com.g12shop.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;

import com.g12shop.entity.Accounts;
import com.g12shop.util.UserNotFoundExcepion;

public interface AccountsService {

	List<Accounts> findAll();

	//Login
	Accounts doLogin(String usernameOrEmail, String password) throws UserNotFoundExcepion;
	
	//Register
	Accounts doRegister(Accounts account) throws UserNotFoundExcepion;
	//Send mail verification
	void sendVerificationEmail(Accounts account, String siteURL) throws Exception;
	//verification
	Boolean verificationAccount(String verificationCode);
	
	//change-password
	void changePassword(Accounts account, String newPassword);
	
	//take token
	Accounts getResetPasswordToken(String token);
	//forgot-password
	void forgotPassword(String token, String email) throws UserNotFoundExcepion ;
	//send mail confirm accounts
	void sendMailActivated(String email, String linkResetPassword)throws UnsupportedEncodingException, MessagingException;
	//Change Pasword
	void updatePassword(Accounts account, String newPassword);
}