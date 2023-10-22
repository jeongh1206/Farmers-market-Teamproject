package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dto.delCVSDTO;

@Controller
public class DeliveryController {
	
	@RequestMapping("/del")
	public String delivery() {
		return "deliveryMain";
	}
	@RequestMapping("/delm")
	public String deliverym() {
		return "delivery/deliveryMethods";
	}
	
	@RequestMapping("/nonMemberDel")
	public String nonMemberDelSearch() {
		return "delivery/nonMemberDeliverySearch";
	}
	
	@RequestMapping("/delCVS")
	public String delCVS(Model m,delCVSDTO delCVS) {
		//System.out.println(delCVS);
		m.addAttribute("delCVS", delCVS);
		return "delivery/delCVS";
	}
	
}
