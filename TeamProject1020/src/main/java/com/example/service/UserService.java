package com.example.service;

import java.util.List;

import javax.annotation.Priority;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.example.dao.UserDAO;
import com.example.dto.UserDTO;
import com.example.dto.kakaoToken;
@Service
public class UserService{
	
	@Autowired
	UserDAO dao; 

	public int insertBuyer(UserDTO dto) {
		return dao.insertBuyer(dto);
	}

	public UserDTO selectBuyerByid(String id) {
		return dao.selectBuyerByid(id);
	}

	public UserDTO login(UserDTO dto) {
		return dao.login(dto);
	}

	public UserDTO findId(UserDTO dto) {
		return dao.findId(dto);
		
	}
	public UserDTO findPw(UserDTO dto) {
		return dao.findPw(dto);
		
	}

	public String add_idCheck(String user_id) {
		return dao.add_idCheck(user_id);
	}

	public String add_nicknameCheck(String user_nickname) {
		return dao.add_nicknameCheck(user_nickname);
	}

	public String add_emailCheck(String user_email) {
		return dao.add_emailCheck(user_email);
	}

	
	public String add_phoneCheck(String user_phone) {
		return dao.add_phoneCheck(user_phone);
	}
	
	//닉네임 미입력 시 userno로 자동 입력
	public void insertNcknm(UserDTO dto) {
		//insert할 때 쓰인 시퀀스 - user_no를 구해서 그걸 별명에 insert해줄 것
		//1. insert 시 바로 생성된 userno를 구한다.
			int num = dao.add_noCheck(dto);
		//2. 그걸 nickname에 user10이런식으로  넣는다.
			dto.setUser_nickname("user"+num);
			dao.insertNcknm(dto);
	}//insertNckcnm

	//카카오 유저 정보 추가 입력
	public void updateKakaoUser(UserDTO dto) {
		dao.updateKakaoUser(dto);
		
	}

	public void updatePw(UserDTO dto) {
		dao.updatePw(dto);
		
	}

	public String pwForLogin(String user_id) {
		return dao.pwForLogin(user_id);
	}

	public UserDTO myPage(int user_no) {
		return dao.myPage(user_no);
	}

	

}//class
