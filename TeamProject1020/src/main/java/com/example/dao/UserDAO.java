package com.example.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.UserDTO;

@Repository
public class UserDAO{
	
	@Autowired
	SqlSessionTemplate session;
	
	//회원가입
	public int insertBuyer(UserDTO dto) {
		return session.insert("addBuyer", dto);
	}//method

	
	public UserDTO selectBuyerByid(String id) {
		return session.selectOne("selectBuyerByid",id);
	}

	 //회원로그인
	public UserDTO login(UserDTO dto) {
		return session.selectOne("login",dto);
	}

	//카카오로그인
	public int insertkakao(UserDTO dto, SqlSessionTemplate session) {
		if(dto.getUser_email()!=null) {
			return session.insert("insertkakao", dto);
		}else {
			return session.insert("insertkakaoNoMail",dto);
		}
	}

	
	public UserDTO findId(UserDTO dto) {
		return session.selectOne("findId",dto);
	}
	public UserDTO findPw(UserDTO dto) {
		return session.selectOne("findPw",dto);

	}

	//회원가입 유효성 검사
	public String add_idCheck(String user_id) {
		return session.selectOne("add_idCheck",user_id);
	}

	public String add_phoneCheck(String user_phone) {
		return session.selectOne("add_phoneCheck",user_phone);
	}
	
	public String add_nicknameCheck(String user_nickname) {
		return session.selectOne("add_nicknameCheck",user_nickname);
	}


	public String add_emailCheck(String user_email) {
		return session.selectOne("add_emailCheck",user_email);

	}


	public int add_noCheck(UserDTO dto) {
		return session.selectOne("add_noCheck",dto);
	}
	//회원가입 유효성 검사 끝.

	//회원가입 - 별명 미설정 시 자동 설정
	public int insertNcknm(UserDTO dto) {
		return session.update("insertNcknm",dto);
	}
	
	//카카오 유저 회원가입 시 
	public void updateKakaoUser(UserDTO dto) {
		session.update("updateKakaoUser",dto);
	}


	public void updatePw(UserDTO dto) {
		session.update("updatePw",dto);
		
	}


	public String pwForLogin(String user_id) {
		return session.selectOne("pwForLogin",user_id);
	}

	public UserDTO myPage(int user_no) {
		return session.selectOne("UserMapper.mypage", user_no);
	}



}
