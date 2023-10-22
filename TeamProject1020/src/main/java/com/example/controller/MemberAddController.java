package com.example.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.UserService;
//회원가입 시 필요한 정보만 관리. responsebody 설정된 컨트롤러

@RestController
public class MemberAddController {
	@Autowired
	UserService service = new UserService();
	
	//아이디 검사 - db 통해 중복된 아이디/ 사용 가능 아이디 확인
	@RequestMapping("/register/add_idCheck")
	public Map<String, Object> add_idCheck(@RequestParam String user_id) {
		 Map<String, Object> response = new HashMap<>();
		 
		String db_id = service.add_idCheck(user_id);
		if(db_id!=null) {
			
			response.put("str", "중복된 아이디입니다.");
			response.put("result", false);
		}else {
		response.put("str", "<span style='color:blue'>사용 가능한 아이디입니다.</span>");	
		response.put("result", true);
		}//else
		return  response;
	}//method


	//별명검사 - db 통해 중복된  별명/ 사용 가능 별명 확인
	@RequestMapping("/register/add_nicknameCheck")
	public  Map<String, Object> add_nicknameCheck(@RequestParam String user_nickname) {
		 Map<String, Object> response = new HashMap<>();
		String db_nickname = service.add_nicknameCheck(user_nickname);
		if(db_nickname!=null) {
			response.put("str", "중복된 별명입니다.");
			response.put("result", false);

			}else {
				response.put("str", "<span style='color:blue'>사용 가능한 별명입니다.</span>");	
				response.put("result", true);
				}//else
				return  response;
	}//method

	//phone
	@RequestMapping("/register/add_phoneCheck")
	public Map<String, Object> add_phoneCheck(@RequestParam String user_phone) {
		 Map<String, Object> response = new HashMap<>();
		String db_phone = service.add_phoneCheck(user_phone);
		if(db_phone!=null) {
			response.put("str", "중복된 번호입니다.");
			response.put("result", false);

		}else {
			response.put("str", "");	
			response.put("result", true);
			}//else
			return  response;
	}//method
	
	@RequestMapping("/register/add_emailCheck")
	public Map<String, Object> add_emailCheck(@RequestParam String user_email) {
		 Map<String, Object> response = new HashMap<>();
		String db_email = service.add_emailCheck(user_email);
		if(db_email!=null) {
			response.put("result", false);

		}else {
			response.put("result", true);
			}//else
			return  response;
	}//method

	@RequestMapping("/register/add_refCheck")
	public Map<String, Object> add_refCheck(@RequestParam String user_nickname) {
		 Map<String, Object> response = new HashMap<>();
		String db_nickname = service.add_nicknameCheck(user_nickname);
		if(db_nickname==null) {
			response.put("str", "추천인이 없습니다.");
			response.put("result", false);
		}else {
		response.put("str", "");
		response.put("result", true);
		}//else
		return  response;
		}//method
	}//class
