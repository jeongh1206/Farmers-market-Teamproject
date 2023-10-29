package com.example.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.CsInqDTO;
import com.example.dto.FileDTO;
import com.example.dto.UserDTO;
import com.example.service.CustomerServiceService;

@Controller
public class AdminMainController {
//	@Value("${upload.path}")
//		private String uploadPath;	
	@Autowired
	CustomerServiceService service;
	
	@GetMapping("/adm_csInqList")
	public ModelAndView csInqList() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("CsInq",service.adm_csInqAll());
		mav.setViewName("/ADMIN/csInqList");
		
		return mav;
	}//
	
	//문의 상세 반환
	@ResponseBody
	@PostMapping("/adm_csInqRetrieve")
	public JSONObject csInqRetrieve(int inq_no,HttpSession session) {
		 session.removeAttribute("inqAnswer");
	     
		 JSONObject jsonObject = new JSONObject();
	     //문의 객체
	     CsInqDTO dto = new CsInqDTO();
	     dto = service.adm_inqByInq_NO(inq_no);
	     jsonObject.put("CsInqRetrieve", dto);
	    
	     //파일 객체 list
	     List fList = new ArrayList<FileDTO>();
	     fList = service.selectFileByInqNo(inq_no);
	     List fList2 = new ArrayList<FileDTO>();

	     
         //파일이 있음
         if(fList.size()!=0) {
        	 for (Object f : fList) {
        		 fList2.add(f);
			}//for
        	 jsonObject.put("fileList", fList2);
         }//if
         
         if(dto.getInq_answer()!=null) {
    		 session.setAttribute("inqAnswer",dto.getInq_answer());
         }
      return jsonObject;
	}//method

	
	//파일 시퀀스 기준 하나의 파일 불러오기
	@ResponseBody 
	@PostMapping("/adm_csImgRetrieve")
	public FileDTO adm_csImgRetrieve(int file_no) {
		FileDTO file = service.adm_fileByfile_No(file_no);
		return file;
	}

	@PostMapping("/adm_inqAnswer")
	public ModelAndView adm_inqAnswer(String inq_no,String inq_answer){
		CsInqDTO dto = new CsInqDTO();
		dto.setInq_no(Integer.parseInt(inq_no));
		dto.setInq_answer(inq_answer);
		ModelAndView mav =new ModelAndView();
		service.adm_updateInqAnswer(dto);
		mav.setViewName("redirect:/adm_csInqList");
		return mav;
	}
	
	@ResponseBody
	@GetMapping("/adm_delInq")
	public void adm_delInq(int inq_no){
		service. csInqDelByInqNo(inq_no);
	}
	
	
}
