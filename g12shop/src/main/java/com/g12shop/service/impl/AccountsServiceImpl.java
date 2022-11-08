package com.g12shop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.entity.Accounts;
import com.g12shop.repository.AccountsRepo;
import com.g12shop.service.AccountsService;

@Service
public class AccountsServiceImpl implements AccountsService {

	@Autowired
	private AccountsRepo repo;
	
	@Autowired
	private EncoderConfig encoderConfig;

	@Override
	public List<Accounts> findAll() {
		return repo.findAll();
	}

	@Override
	public Accounts doLogin(String usernameOrEmail, String password) throws UserNotFoundExcepion {
		Accounts accountResponse = repo.findByUsernameOrEmailAndIsEnabledAndIsDeleted(usernameOrEmail, usernameOrEmail, Boolean.TRUE, Boolean.FALSE);
		
		if(accountResponse == null) {
			throw new UserNotFoundExcepion("Account is not exists!");
		}else if(accountResponse.getIsEnabled() == false) {
			throw new UserNotFoundExcepion("Account not activated!");
		}else if(accountResponse.getIsDeleted() == true) {
			throw new UserNotFoundExcepion("Account has been deleted");
		}else {
			Boolean checkPassword = encoderConfig.passwordEncoder().matches(password, accountResponse.getHashPassword());
			return checkPassword ? accountResponse : null;
		}
	}

	@Override
	public List<Accounts> findAll() {
		return accountsRepo.findAll();
	}
}
