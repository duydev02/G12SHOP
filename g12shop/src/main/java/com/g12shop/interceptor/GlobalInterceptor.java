package com.g12shop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.g12shop.service.CategoriesService;
import com.g12shop.service.ProductTypesService;
import com.g12shop.service.ProductsService;

@Component
public class GlobalInterceptor implements HandlerInterceptor{
	@Autowired 
	private CategoriesService categoriesService;
	
	@Autowired
	private ProductsService productsService;
	
	@Autowired
	private ProductTypesService productTypesService;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		request.setAttribute("categories", categoriesService.findAll());
		request.setAttribute("products", productsService.findAll());
		request.setAttribute("productTypes", productTypesService.findAllName());
	}
}
