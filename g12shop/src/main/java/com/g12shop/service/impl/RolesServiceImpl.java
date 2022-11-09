package com.g12shop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.entity.Roles;
import com.g12shop.repository.RolesRepo;
import com.g12shop.service.RolesService;

@Service
public class RolesServiceImpl implements RolesService {

	@Autowired
	private RolesRepo repo;
	
	@Override
	public Roles findByName(String name) {
		// TODO Auto-generated method stub
		return repo.findByName(name);
	}
}
