package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	//시작 시 
	@RequestMapping("/")
	public String start(){
		return "main";
	}//method
	
	@RequestMapping("/main")
	public String main() {
		return "main";
	}

//	@RequestMapping("/pList")
//	public String pList() {
//		return "pList";
//	}
	

	
	
}	
