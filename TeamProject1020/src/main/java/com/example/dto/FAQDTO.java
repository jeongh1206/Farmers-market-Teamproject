package com.example.dto;

public class FAQDTO {
	private String FAQ_no;
	private String FAQ_type;
	private String FAQ_title;
	private String FAQ_content;
	private String FAQ_DELDATE;
	
	public FAQDTO() {
		super();
	}
	
	public FAQDTO(String fAQ_no, String fAQ_type, String fAQ_title, String fAQ_content, String fAQ_DELDATE) {
		super();
		FAQ_no = fAQ_no;
		FAQ_type = fAQ_type;
		FAQ_title = fAQ_title;
		FAQ_content = fAQ_content;
		FAQ_DELDATE = fAQ_DELDATE;
	}
	
	
	public String getFAQ_no() {
		return FAQ_no;
	}

	public void setFAQ_no(String fAQ_no) {
		FAQ_no = fAQ_no;
	}

	public String getFAQ_type() {
		return FAQ_type;
	}

	public void setFAQ_type(String fAQ_type) {
		FAQ_type = fAQ_type;
	}

	public String getFAQ_title() {
		return FAQ_title;
	}

	public void setFAQ_title(String fAQ_title) {
		FAQ_title = fAQ_title;
	}

	public String getFAQ_content() {
		return FAQ_content;
	}

	public void setFAQ_content(String fAQ_content) {
		FAQ_content = fAQ_content;
	}

	public String getFAQ_DELDATE() {
		return FAQ_DELDATE;
	}

	public void setFAQ_DELDATE(String fAQ_DELDATE) {
		FAQ_DELDATE = fAQ_DELDATE;
	}

	@Override
	public String toString() {
		return "FAQDTO [FAQ_no=" + FAQ_no + ", FAQ_type=" + FAQ_type + ", FAQ_title=" + FAQ_title + ", FAQ_content="
				+ FAQ_content + ", FAQ_DELDATE=" + FAQ_DELDATE + "]";
	}
	
	
}
