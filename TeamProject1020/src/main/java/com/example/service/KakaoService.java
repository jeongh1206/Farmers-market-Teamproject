package com.example.service;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.example.dao.UserDAO;
import com.example.dto.KakaoUser;
import com.example.dto.UserDTO;
import com.example.dto.kakaoToken;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoService{
	
	@Autowired
	SqlSessionTemplate session;
	
	
	@Autowired
	private UserDAO dao;
	
	//카카오 로그인 통해 토큰 받기
	public kakaoToken requestToken(String code) {
		 kakaoToken kakaoToken = new kakaoToken(); 
	    	//request를 보낼 주소
    	 String strUrl = "https://kauth.kakao.com/oauth/token"; 
    	  try{
    		  	URL url = new URL(strUrl);
    		  	 HttpURLConnection conn = (HttpURLConnection) url.openConnection(); //url Http 연결 생성

	            //POST 요청
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);//outputStreamm으로 post 데이터를 넘김
	            
	            
	            //파라미터 세팅
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("grant_type=authorization_code");
	            
	            //1. client_id. restAPI key.
	            sb.append("&client_id=7a1205ee947ccd366f1de0b2e595c6d5");
	            
	            //2. redirect_uri 미리 설정한 redirect uri로 해야함.
	            sb.append("&redirect_uri=http://localhost:8093/app/callback");
	            
	            //3. 인자로 받아온 인증코드
	            sb.append("&code=" + code);	
	            bw.write(sb.toString());
	            bw.flush();//실제 요청을 보내는 부분
	            
	            //실제 요청을 보내는 부분, 결과 코드가 200이라면 성공
	            int responseCode = conn.getResponseCode();
	            //System.out.println(("responsecode(200이면성공): {}"+responseCode));
	            
	            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	           
	            while ((line = br.readLine()) != null) {
	                result += line;
	                //System.out.println("result 확인"+result);
	                //result가 json으로 받아짐.
	            }
	            
	            //Jackson으로 json 파싱할 것임
	            ObjectMapper mapper = new ObjectMapper();
	            //kakaoToken에 result를 KakaoToken.class 형식으로 변환하여 저장
	            kakaoToken = mapper.readValue(result, kakaoToken.class);

	            //api호출용 access token 확인
	            //String access_Token = kakaoToken.getAccess_token();
	            //System.out.println(access_Token);
	            
	            //access 토큰 만료되면 refresh token사용(유효기간 더 김)
	            //String refresh_Token=kakaoToken.getRefresh_token();

	            
	            br.close();
	            bw.close();
    	  }catch (Exception e) {
              e.printStackTrace();
          }
		return kakaoToken;
	}//requestToken
	
	public KakaoUser requestUser(String accessToken){
		//response를 받을 객체
		KakaoUser user = new KakaoUser();
		
		//request를 보낼 주소
		String strUrl = "https://kapi.kakao.com/v2/user/me"; 
		
		 try{
		        URL url = new URL(strUrl);
		      //url Http 연결 생성	
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection(); 
		        //POST 요청
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);//outputStreamm으로 post 데이터를 넘김
	          //전송할 header 작성, 인자로 받은 access_token전송
	            conn.setRequestProperty("Authorization", "Bearer " + accessToken);


	            //실제 요청을 보내는 부분, 결과 코드가 200이라면 성공
	            int responseCode = conn.getResponseCode();

	            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";

	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            br.close();

	            //Jackson으로 json 파싱할 것임
	            ObjectMapper mapper = new ObjectMapper();
	            //결과 json을 HashMap 형태로 변환하여 resultMap에 담음
	            HashMap<String,Object> resultMap = mapper.readValue(result, HashMap.class);
	            //json 파싱하여 id 가져오기
	            Long id = Long.valueOf(String.valueOf(resultMap.get("id")));

	            //결과json 안에 properties key는 json Object를 value로 가짐
	            HashMap<String,Object> properties = (HashMap<String, Object>) resultMap.get("properties");
	            String nickname = (String)properties.get("nickname");

	            //결과json 안에 kakao_account key는 json Object를 value로 가짐
	            HashMap<String,Object> kakao_account = (HashMap<String, Object>) resultMap.get("kakao_account");
	            String email=null;//이메일은 동의해야 알 수 있음
	            if(kakao_account.containsKey("email")){//동의하면 email이 kakao_account에 key로 존재함
	                email=(String)kakao_account.get("email");
	              //유저정보 세팅
		            user.setEmail(email);
	            }//if
	          
	            user.setId(id);
	            user.setNickname(nickname);
	            
	            
	            
		    }catch (IOException e) {
		        e.printStackTrace();
		    }
		    return user;
		
	}//requestUser

	public int insertkakao(UserDTO dto) {
		return dao.insertkakao(dto,session);
	}//insertkakao
	

}