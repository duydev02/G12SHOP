package com.g12shop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.entity.ProductTypes;
import com.g12shop.repository.ProductTypesRepo;
import com.g12shop.service.ProductTypesService;

@Service
public class ProductTypesServiceImpl implements ProductTypesService{

	@Autowired
	private ProductTypesRepo repo;

	@Override
	public List<ProductTypes> findAll() {
		// TODO Auto-generated method stub
		return repo.findByIsDeleted(Boolean.FALSE);
	}

	@Override
	public Optional<ProductTypes> findById(Long id) {
		return repo.findById(id);
	}
	
}
