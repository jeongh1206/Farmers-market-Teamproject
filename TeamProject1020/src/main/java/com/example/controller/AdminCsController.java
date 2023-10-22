package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.CsInqDTO;
import com.example.service.CustomerServiceService;

@RestController
//관리자 - 고객센터
public class AdminCsController {
	@Autowired
	CustomerServiceService service;
	
	@PostMapping("/cs/adm_InquiryList")
	public JSONObject adm_InquiryList(HttpSession session) {
		List<CsInqDTO> list = new ArrayList<CsInqDTO>();
		list = service.csInqAll();
		  JSONObject jsonObject = new JSONObject();
	      jsonObject.put("CsInq", list);
	    //  String jsonInfo=jsonObject.toString();
		return jsonObject;
	};//method
}//controller
