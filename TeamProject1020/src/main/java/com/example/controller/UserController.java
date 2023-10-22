package com.example.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.example.dto.UserDTO;
import com.example.service.EmailService;
import com.example.service.KakaoService;
import com.example.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@Autowired
	KakaoService kakaoService;

	@Autowired
	EmailService emailService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping("/test")
	public String test() {
		return "NewFile";
	}
	//기능: 회원가입폼으로 이동
	@RequestMapping("/register/addBuyerUI")
	public String addBuyerUI(HttpSession session){
		if(session.getAttribute("login")!=null) {
			session.setAttribute("mesg", "이미 가입된 회원입니다.");
			
			return "main";
		}
		return"user/Buyer";
	}//method
	
	//기능: 회원가입
	@RequestMapping(value = "/register/addBuyer",method = RequestMethod.POST)
	public ModelAndView addBuyer(UserDTO dto,HttpSession session){
		//비밀번호 단방향 암호화
		dto.setUser_pw(passwordEncoder.encode(dto.getUser_pw()));
		
		//회원가입 실패는 나중에 필요 시 구현.
		service.insertBuyer(dto);
		if(dto.getUser_nickname().length()==0) {
			service.insertNcknm(dto);
		}
		ModelAndView mav = new ModelAndView();
		session.setAttribute("mesg", "회원가입이 완료되었습니다.");
		mav.setViewName("redirect:/main");
		return mav;
	}//method
	
	//기능: 로그인폼으로 이동
	@GetMapping("/login/UI")
	public String loginUI(HttpSession session,HttpServletRequest request){
		if(	session.getAttribute("login")!=null) {
			session.setAttribute("mesg", "이미 로그인된 회원입니다.");
		return("redirect:/main");
		}
	    
		return "login/login";	
	}//method
	
	/* 로그인 에러메세지 처리*/
	@GetMapping("/authlogin")
	public String login(@RequestParam(value = "exception", required = false) String exception,
						HttpSession session) {
		
		session.setAttribute("warning", exception);
		return("redirect:/login/UI");
	}
	
	@GetMapping("/denied")
    public String accessDenied(@RequestParam(value = "exception",required = false) String exception,
    		HttpSession session){
		session.setAttribute("warning", exception);
		return("redirect:/login/UI");
    }
	

		//기능: 아이디 찾기 페이지로 이동
		@GetMapping("/login/findIdUI")
		public String findIdUI()
		{	
			return "login/FindId";
		}
		
		//기능: 아이디 찾기 페이지 통해서 아이디 찾기
		@PostMapping("/login/findId")
		public ModelAndView findId(String user_name,String email1,String email2)
		{	
			//이름과 이메일이 맞는게 있으면 아이디를 보여준다.
			String user_email = email1+"@"+email2;
			ModelAndView mav = new ModelAndView(); 
			
			//이름과 이메일 통해 아이디 찾기
			UserDTO dto = new UserDTO();
			dto.setUser_name(user_name);
			dto.setUser_email(user_email);
		
			if(service.findId(dto)==null) {
				String str =  "확인된 정보가 없습니다.";
				str += 	"<br><a href='/app/login/findIdUI'>아이디 찾기</a><br>";
				mav.addObject("findId",str);
			
			} else{//dto 값은 있는데 카카오 계정이라면
				dto = service.findId(dto);
				if(dto.getUser_type().equals("kakao")) {
					mav.addObject("findId", "카카오 간편 로그인으로 가입한 계정입니다.");
					
					
					//dto값이 카카오 계정이 아니면
				}else if(dto.getUser_type().equals("member")){
				mav.addObject("findId", "고객님의 아이디는 "+dto.getUser_id()+"입니다.");
				}//else if
				else {
					String str =  "회원 유형을 확인해주세요";
					str += 	"<br><a href='/app/login/findIdUI'>아이디 찾기</a><br>";
					mav.addObject("findId",str);
				
				}
			}//else 
			mav.setViewName("login/FindId");
			return mav;
		}//method
		
		//기능: 비밀번호 찾기 페이지로 이동
		@RequestMapping("/login/findPwUI")
		public String findPwUI()
		{
			return "login/FindPw";
		}
		//기능: 비밀번호 찾기 - 비밀번호 재설정 페이지로 이동
		@PostMapping("/login/findPw")
		public ModelAndView findPw(HttpSession session,String user_id,String email1,String email2)
		{
			ModelAndView mav = new ModelAndView();
			String user_email = email1+"@"+email2;
			UserDTO dto = new UserDTO();
			dto.setUser_id(user_id);
			dto.setUser_email(user_email);
			//파싱 확인 끝.
			dto = service.findPw(dto);
			//맞는게 있으면 id 정보를 저장하고
			if(dto!=null) {
				mav.addObject("user_id",user_id);
				mav.setViewName("login/resetPw");
			}else {
				mav.setViewName("redirect:findPwUI");
				session.setAttribute("mesg","사용자 정보가 없습니다.");
			}//else
			return mav;
		}

		//기능: 비밀번호 재설정
		@PostMapping("/login/resetPw")
		public ModelAndView resetPw(HttpSession session,String user_id,String user_pw)
		{
			ModelAndView mav = new ModelAndView();
			UserDTO dto = new UserDTO();
			dto.setUser_id(user_id);
			dto = service.selectBuyerByid(user_id);
			//System.out.println("selectById하고 "+dto);
			//id를 기준으로 정보를 찾아오는데 그 값이 없으면
			if(dto==null) {
				session.setAttribute("mesg","사용자 정보가 없습니다. 다시 시도해주세요.");
			}else { //있으면 정상 진행
				//비밀번호 단방향 암호화
				user_pw = passwordEncoder.encode(user_pw);
				dto.setUser_pw(user_pw);
				//비밀번호 재설정
				service.updatePw(dto);
				mav.addObject("user_id","아이디 확인 완료");
				session.setAttribute("mesg","비밀번호 재설정이 완료되었습니다.");
			}//else
			mav.setViewName("login/resetPw");
			return mav;
		}

		//기능: 이메일 인증코드 발송
		@ResponseBody
		@PostMapping("/mailConfirm")
//	    public ResponseEntity<String> sendVerificationEmail(@RequestParam String toEmail) {
		public ResponseEntity<String> sendVerificationEmail(String user_email,HttpServletRequest request) {
			try {
	            String confirmationCode = emailService.sendSimpleMessage(user_email);
	            return ResponseEntity.ok("Verification email sent with code: " + confirmationCode);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return ResponseEntity.badRequest().body("Failed to send verification email.");
	        }//catch
	    }//method
		
		@RequestMapping("/childEmail_verification")
		//기능: 이메일 인증 창으로 이동
		public ModelAndView childEmail_verification(String emailcode) {
			ModelAndView mav = new ModelAndView();
			mav.addObject("emailcode",emailcode);
			mav.setViewName("user/childEmail_verification");
			return mav;
		}
	
}
