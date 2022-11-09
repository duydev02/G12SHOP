package com.g12shop.service;

import java.util.List;

import com.g12shop.entity.Accounts;
import com.g12shop.util.UserNotFoundExcepion;

public interface AccountsService {

	List<Accounts> findAll();

	Accounts doLogin(String usernameOrEmail, String password) throws UserNotFoundExcepion;
}
