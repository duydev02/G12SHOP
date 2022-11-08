package com.g12shop.service;

<<<<<<< Updated upstream
public interface AccountsService {

=======
import java.util.List;

import com.g12shop.Util.UserNotFoundExcepion;
import com.g12shop.entity.Accounts;

public interface AccountsService {

	List<Accounts> findAll();

	Accounts doLogin(String usernameOrEmail, String password) throws UserNotFoundExcepion;
>>>>>>> Stashed changes
}
