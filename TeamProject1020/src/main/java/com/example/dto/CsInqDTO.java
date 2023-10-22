package com.example.dto;

public class CsInqDTO {
	
	private int inq_no;
	private String inq_type;
	private String inq_title;
	private String  inq_content;
	private int user_no;
	private String inq_update;
	private String inq_deldate;
	private String inq_answer;
	private String inq_state;
	private String inq_created_date;
	
	public CsInqDTO() {
		super();
	}
	
	public CsInqDTO(int inq_no, String inq_type, String inq_title, String inq_content, int user_no, String inq_update,
			String inq_deldate, String inq_answer, String inq_state, String inq_created_date) {
		super();
		this.inq_no = inq_no;
		this.inq_type = inq_type;
		this.inq_title = inq_title;
		this.inq_content = inq_content;
		this.user_no = user_no;
		this.inq_update = inq_update;
		this.inq_deldate = inq_deldate;
		this.inq_answer = inq_answer;
		this.inq_state = inq_state;
		this.inq_created_date = inq_created_date;
	}

	public int getInq_no() {
		return inq_no;
	}

	public void setInq_no(int inq_no) {
		this.inq_no = inq_no;
	}

	public String getInq_type() {
		return inq_type;
	}

	public void setInq_type(String inq_type) {
		this.inq_type = inq_type;
	}

	public String getInq_title() {
		return inq_title;
	}

	public void setInq_title(String inq_title) {
		this.inq_title = inq_title;
	}

	public String getInq_content() {
		return inq_content;
	}

	public void setInq_content(String inq_content) {
		this.inq_content = inq_content;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getInq_update() {
		return inq_update;
	}

	public void setInq_update(String inq_update) {
		this.inq_update = inq_update;
	}

	public String getInq_deldate() {
		return inq_deldate;
	}

	public void setInq_deldate(String inq_deldate) {
		this.inq_deldate = inq_deldate;
	}

	public String getInq_answer() {
		return inq_answer;
	}

	public void setInq_answer(String inq_answer) {
		this.inq_answer = inq_answer;
	}

	public String getInq_state() {
		return inq_state;
	}

	public void setInq_state(String inq_state) {
		this.inq_state = inq_state;
	}

	public String getInq_created_date() {
		return inq_created_date;
	}

	public void setInq_created_date(String inq_created_date) {
		this.inq_created_date = inq_created_date;
	}

	@Override
	public String toString() {
		return "CsInqDTO [inq_no=" + inq_no + ", inq_type=" + inq_type + ", inq_title=" + inq_title + ", inq_content="
				+ inq_content + ", user_no=" + user_no + ", inq_update=" + inq_update + ", inq_deldate=" + inq_deldate
				+ ", inq_answer=" + inq_answer + ", inq_state=" + inq_state + ", inq_created_date=" + inq_created_date
				+ "]";
	}
}//class
