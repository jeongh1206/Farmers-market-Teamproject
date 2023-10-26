package com.example.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.CsInqDTO;
import com.example.dto.FileDTO;
import com.example.service.CustomerServiceService;

@Controller
public class AdminMainController {
	@Value("${upload.path}")
		private String uploadPath;	
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
	public JSONObject csInqRetrieve(int inq_no) {
	     JSONObject jsonObject = new JSONObject();
	     //문의 객체
	     CsInqDTO dto = new CsInqDTO();
	     dto = service.adm_inqByInq_NO(inq_no);
	     jsonObject.put("CsInqRetrieve", dto);
	    
	     //파일 객체 list
	     List fList = new ArrayList<FileDTO>();
	     fList = service.selectFileByInqNo(inq_no);
        
	     List fList2 = new ArrayList<File>();
	     
         //파일이 있음
         if(fList.size()!=0) {
        	 for (Object f : fList) {
        		 String folderpath = ((FileDTO)f).getSaveFileName();
        		 String name = ((FileDTO)f).getFileName();
        		 
        		 String path = uploadPath+((FileDTO)f).getSaveFileName()+name;
        		 System.out.println(path);
        		 File file = new File(path);
        		 fList2.add(file);	
			}//for
        	 jsonObject.put("fileList", fList2);
         }//if
      return jsonObject;
	}//method


	
}
