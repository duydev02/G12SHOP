package com.g12shop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.g12shop.entity.ProductTypes;
import com.g12shop.entity.Products;
import com.g12shop.repository.ProductsRepo;
import com.g12shop.service.ProductsService;

@Service
public class ProductsServiceImpl implements ProductsService {

	@Autowired
	private ProductsRepo repo;

	@Override
	public Optional<Products> findById(Long id) {
		return repo.findById(id);
	}

	@Override
	public Products findBySlug(String slug) {
		return repo.findBySlug(slug);
	}

	@Override
	public List<Products> findByDiscount() {
		return repo.findByDiscountGreaterThan(0);
	}

	@Override
	public List<Products> findByCategoryIdAndDiscount(Long categoryId) {
		return repo.findByCategoryIdAndDiscountGreaterThan(categoryId, 0);
	}
	
	@Override
	public List<Products> findAll() {
		// TODO Auto-generated method stub
		return repo.findByIsDeletedAndQuantityGreaterThan(Boolean.FALSE, 0);
	}

	@Override
	public Page<Products> findAll(int pageSize, int pageNumber) throws Exception {
		if(pageNumber >= 1) {
            return repo.findByIsDeletedAndQuantityGreaterThan(Boolean.FALSE, 0, PageRequest.of(pageNumber - 1 , pageSize));
        } else {
            throw new Exception("Page number must be greater than 0");
        }
	}

	@Override
	public List<Products> findByRelatedProducts(ProductTypes productType, String slug) {
		return repo.findByProductTypeAndSlugNotAndIsDeletedAndQuantityGreaterThan(productType, slug, Boolean.FALSE, 0);
	}

	@Override
	public List<Products> findAllByCategoryId(Long categoryId) {
		return repo.findByCategoryIdAndIsDeletedAndQuantityGreaterThan(categoryId, Boolean.FALSE, 0);
	}

	@Override
	public Page<Products> findAllByCategoryId(Long categoryId, int pageSize, int pageNumber) throws Exception {
		if(pageNumber >= 1) {
            return repo.findByCategoryIdAndIsDeletedAndQuantityGreaterThan(categoryId, Boolean.FALSE, 0, PageRequest.of(pageNumber - 1 , pageSize));
        } else {
            throw new Exception("Page number must be greater than 0");
        }
	}

	@Override
	public List<Products> findByKeywords(String key) {
		return repo.findByKeywords(key);
	}

	@Override
	public Page<Products> findByKeywords(String key, int pageSize, int pageNumber) throws Exception {
		if(pageNumber >= 1) {
            return repo.findByKeywords(key, PageRequest.of(pageNumber - 1 , pageSize));
        } else {
            throw new Exception("Page number must be greater than 0");
        }
	}

}
