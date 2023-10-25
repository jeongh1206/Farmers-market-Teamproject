package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.service.CustomerServiceService;

@Controller
public class AdminMainController {
	@Autowired
	CustomerServiceService service;
	
	@GetMapping("/adm_csInqList")
	public ModelAndView csInqList() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("CsInq",service.adm_csInqAll());
		mav.setViewName("/ADMIN/csInqList");
		return mav;
	}//
	@GetMapping("/adm_csInqRetrieve")
	public ModelAndView csInqRetrieve(int inq_no) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("CsInq",service.adm_inqByInq_NO(inq_no));
		mav.setViewName("/ADMIN/csInqRetrieve");
		return mav;
	}//
	

	
}
