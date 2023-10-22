package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminMainController {
	@GetMapping("/csInqList")
	public String csInqList() {
		return "/ADMIN/csInqList";
	}//
	
}
