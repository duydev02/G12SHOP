package com.g12shop.service;

import java.util.List;

import com.g12shop.entity.Categories;

public interface CategoriesService {

	List<Categories> findAll();

	Categories findBySlug(String slug);
}
