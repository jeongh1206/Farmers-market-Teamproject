package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.UserDTO;
import com.example.service.CartService;
import com.example.service.ProductService;

@Controller
public class ProductListController {

	@Autowired
	ProductService service;

	@Autowired
	CartService service2;

	@RequestMapping("/productList")
	public String productList() {
		return "productList";
	}
	

	@RequestMapping("/getProductList") 
	public @ResponseBody Map<String, Object> getProductList(HttpSession session, @RequestParam HashMap<Object, Object> filter){
		Map<String, Object> allList = new HashMap<>();
		// 필터값 서비스로 넘겨줌.
		//System.out.println("여기다"+filter);
		List<HashMap<String, Object>> productList = new ArrayList<>();
		productList = service.getProductList(filter);
		allList.put("productList", productList);
		
		List<HashMap<String, Object>>getCartList = new ArrayList<>();
		UserDTO Udto = (UserDTO) session.getAttribute("login");
		
		if(Udto != null) {
			filter.put("user_no", Udto.getUser_no());
			getCartList = service2.getCartList(filter);
			allList.put("cartList", getCartList);
		}
		
		return allList;
	}
	
}
