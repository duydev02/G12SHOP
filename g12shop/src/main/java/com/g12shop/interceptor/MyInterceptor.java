package com.g12shop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.g12shop.entity.Users;
import com.g12shop.service.SessionService;

@Component
public class MyInterceptor implements HandlerInterceptor {

	@Autowired
	private SessionService sessionService;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		String uri = req.getRequestURI();
		Users user = sessionService.get("currentUser"); // lấy từ session

		String error = "";

		if (user == null) // chưa đăng nhập
		{
			error = "Please login!";
		}
		// không đúng vai trò
		else if (!user.getRole().getName().equals("admin") && uri.startsWith("/admin")) {
			error = "Access denied!";
		}
		if (error.length() > 0) {
			sessionService.set("security-uri", uri);
			resp.sendRedirect("/login?error=" + error);
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse resp, Object handler, ModelAndView modelandview)
			throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse resp, Object handler, Exception ex)
			throws Exception {
		System.out.println("afterCompletion()->" + req.getRequestURI());

	}
}
