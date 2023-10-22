package com.example.interceptor;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
@Component
public class LoginCheckInterceptor  implements HandlerInterceptor{
	
	public List<String> loginEssential
    = Arrays.asList("/cart", "/cartAdd", "/cartUpdate","/cartDel","/cartAllDel","/cartCheckDel",
    		"/order","/map","/orderDone","/orderList","/orderConfirm","/orderView","/orderDelete","/delCVS",
    		"/mypage","/logout","/logoutDone");
	
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
	System.out.println("preHandle");
	HttpSession session = request.getSession();
	if(session.getAttribute("login") == null) {
		//session.setAttribute("loginMesg", "로그인이 필요합니다");
		response.sendRedirect("/app/loginUI");//servlet-context.xml 
		return false;  //주의
	}else {
		//System.out.println(session.getAttribute("login"));
		return true; //주의
	}
}
@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	System.out.println("postHandle");
		
	}
@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	System.out.println("afterCompletion");
	}

}
