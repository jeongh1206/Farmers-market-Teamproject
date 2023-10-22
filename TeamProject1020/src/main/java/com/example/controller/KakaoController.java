package com.example.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.KakaoUser;
import com.example.dto.UserDTO;
import com.example.dto.kakaoToken;
import com.example.service.KakaoService;
import com.example.service.UserService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class KakaoController {
	
	@Autowired
	private KakaoService service;
	
	@Autowired
	private UserService userService;
	
	
	@RequestMapping("/kakaoLogin")
	public ModelAndView kakaoLogin(){
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("redirect:https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=7a1205ee947ccd366f1de0b2e595c6d5&redirect_uri=http://localhost:8093/app/callback");
    	return mav;
		}
	
    //1. 카카오 로그인 클릭 시 호출. 코드 받아와서 kakaoLogin함수로 연결
    @GetMapping("/callback")
     public ModelAndView callback(@RequestParam String code,HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("redirect:/callback/kakao-redirect");
    	
    	//세션에 코드 저장
    	session.setAttribute("code", code);
		return mav;
    	
    }
    
    //2. redirect 경로 mapping
    @RequestMapping("/callback/kakao-redirect")
    ///////유저 정보 받아오기 - token////////
     public ModelAndView kakaoLogin(HttpSession session) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("redirect:../main");
    	
		//세션에 저장된 코드 가져와서 토큰 가져오기
    	String code = (String) session.getAttribute("code");
		kakaoToken kakaoToken = service.requestToken(code);
		String accessToken =  kakaoToken.getAccess_token();
		
//		//세션에 토큰 저장
		session.setAttribute("kakaoToken", kakaoToken);
		session.setAttribute("accessToken", accessToken);
		
		
		KakaoUser user = service.requestUser(accessToken);
//		System.out.println("카카오 컨트롤러에서 유저 정보확인:"+user);
		 
		 /////////로컬 db와 연결 - id가 있는지 확인해 있으면 로그인, 없으면 회원가입으로 연결
		 //카카오로 가져온 id를 String으로 변환해 db와 타입 맞춘다.
		String id = Long.toString(user.getId());
		UserDTO dto = new UserDTO();
		dto = userService.selectBuyerByid(id);
		
		if(dto!=null) {//id를 통해 저장된 정보가 있다면 그대로 로그인
			 session.setAttribute("login", dto);

		}else {
			///id에 저장된 정보가 없다면 회원가입으로 이동 - 카카오 회원을 로컬db에 저장하는 코드
			
			//dto재설정, dto에 카카오에서 받은 정보 넣기
			//가입 시 추가정보를 입력하라는 페이지 추가
			dto = new UserDTO();
			dto.setUser_id(id);
			dto.setUser_email(user.getEmail());
			dto.setUser_nickname(user.getNickname());
			dto.setUser_type("kakao");
			
			//회원가입
			service.insertkakao(dto);
			dto = userService.selectBuyerByid(id);
			session.setAttribute("login", dto);
			mav.setViewName("redirect:../addDoneUI");
		}
    	return mav;
   }//kakaoLogin
    
  //기능: 카카오로 회원가입 후 마무리 페이지로 이동
  	@RequestMapping("/addDoneUI")
  	public ModelAndView addDoneUI(){
		ModelAndView mav = new ModelAndView(); 
  		mav.setViewName("/user/addDone");
		return mav;
  		
  	}
  	//기능: form통해 넘어온 데이터 db에 저장
  	@PostMapping("/addDone")
  	public ModelAndView addDone(HttpSession session,UserDTO dto){
		ModelAndView mav = new ModelAndView(); 
		
		//세션에 이미 카카오 유저 정보는 저장되어있음.
		//거기서 아이디를 꺼내서 dto를 다시 세팅한다. 
		UserDTO sessionDTO = (UserDTO)session.getAttribute("login");
		dto.setUser_id(sessionDTO.getUser_id());
  		userService.updateKakaoUser(dto);
  		//dto로 받아서 update 후 id 통해 값 다시 받아서 저장
  		dto = userService.selectBuyerByid(dto.getUser_id());
//  		System.out.println("kakaoController의 addDone"+dto);
  		session.setAttribute("login", dto);
		mav.setViewName("redirect:/main");
  		return mav;
  	}
  	
  	
  
}