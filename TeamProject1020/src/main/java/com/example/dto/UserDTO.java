package com.example.dto;

import java.util.Date;

public class UserDTO {
	private int user_no=0;//시퀀스 활용할거라 비워놓는것과 같이 설정
	private String user_name;
	private String user_pw;
	private String user_phone;
	private String user_status="t";//회원상태(탈퇴유무 등)
	private String user_id;
	private String user_email;
	private String user_ref; //추천인
	private Date user_regdate;//회원가입일
	private Date user_update;//회원정보 수정일
	private String user_nickname;
	private String user_type;
	private int user_post;
	private String user_address1;
	private String user_address2;
	private String user_address3;
	private String roles;

	@Override
	public String toString() {
		return "UserDTO [user_no=" + user_no + ", user_name=" + user_name + ", user_pw=" + user_pw + ", user_phone="
				+ user_phone + ", user_status=" + user_status + ", user_id=" + user_id + ", user_email=" + user_email
				+ ", user_ref=" + user_ref + ", user_regdate=" + user_regdate + ", user_update=" + user_update
				+ ", user_nickname=" + user_nickname + ", user_type=" + user_type + ", user_post=" + user_post
				+ ", user_address1=" + user_address1 + ", user_address2=" + user_address2 + ", user_address3="
				+ user_address3 + ", roles=" + roles + "]";
	}


	public String getroles() {
		return roles;
	}


	public void setroles(String roles) {
		this.roles = roles;
	}


	//생성자
	public UserDTO() {
		super();
	}
	
	
	//id,pw만 받는 생성자
	public UserDTO(String user_id,String user_pw) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
	}


	public int getUser_no() {
		return user_no;
	}


	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getUser_pw() {
		return user_pw;
	}


	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}


	public String getUser_phone() {
		return user_phone;
	}


	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}


	public String getUser_status() {
		return user_status;
	}


	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getUser_email() {
		return user_email;
	}


	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}


	public String getUser_ref() {
		return user_ref;
	}


	public void setUser_ref(String user_ref) {
		this.user_ref = user_ref;
	}


	public Date getUser_regdate() {
		return user_regdate;
	}


	public void setUser_regdate(Date user_regdate) {
		this.user_regdate = user_regdate;
	}


	public Date getUser_update() {
		return user_update;
	}


	public void setUser_update(Date user_update) {
		this.user_update = user_update;
	}


	public String getUser_nickname() {
		return user_nickname;
	}


	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}


	public String getUser_type() {
		return user_type;
	}


	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}


	public int getUser_post() {
		return user_post;
	}


	public void setUser_post(int user_post) {
		this.user_post = user_post;
	}


	public String getUser_address1() {
		return user_address1;
	}


	public void setUser_address1(String user_address1) {
		this.user_address1 = user_address1;
	}


	public String getUser_address2() {
		return user_address2;
	}


	public void setUser_address2(String user_address2) {
		this.user_address2 = user_address2;
	}


	public String getUser_address3() {
		return user_address3;
	}


	public void setUser_address3(String user_address3) {
		this.user_address3 = user_address3;
	}


}
