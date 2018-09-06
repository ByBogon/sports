package com.bybogon.sports.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MainInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler)
			throws Exception {
		HttpSession httpsession = request.getSession();
		
		String path = request.getServletPath();
		String query = request.getQueryString();
		path = path.substring(1);
		
		if (query == null) {
			httpsession.setAttribute("BACK_URL", path);
		} else {
			httpsession.setAttribute("BACK_URL", path+"?"+query);
		}
		
		System.out.println("MainInterceptor - " + path+"?"+query);

		return true;
	}
	
	

}
