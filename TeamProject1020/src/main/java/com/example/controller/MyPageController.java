package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.service.ProductService;

@Controller
public class MyPageController {

	@RequestMapping("/myPage")
	public String myPage() {
		return "myPage";
	}
	
	@RequestMapping("/menu/productList")
	public String productList() {
		return "productList";
	}
	
	
}
