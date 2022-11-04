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
	AccountsRepo accountsRepo;

	@Override
	public List<Accounts> findAll() {
		return accountsRepo.findAll();
	}
	
	
}
