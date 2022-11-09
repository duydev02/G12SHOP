package com.g12shop.util;

import javax.servlet.http.HttpServletRequest;

public class SessionUtil {
	private SessionUtil() {
		
	}
	
	public static String getSiteURL(HttpServletRequest request) {
		String siteURL = request.getRequestURL().toString();
		return siteURL.replace(request.getServletPath(), "");
	}
}
