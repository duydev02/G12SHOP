package com.g12shop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.entity.Categories;
import com.g12shop.repository.CategoriesRepo;
import com.g12shop.service.CategoriesService;

@Service
public class CategoriesServiceImpl implements CategoriesService {
	
	@Autowired
	private CategoriesRepo repo;
	
	@Override
	public List<Categories> findAll() {
		return repo.findByIsDeleted(Boolean.FALSE);
	}

	@Override
	public Categories findBySlug(String slug) {
		return repo.findBySlugAndIsDeleted(slug, Boolean.FALSE);
	}
}
