package com.example.dto;

import java.util.Date;

public class noticeDTO {
	private String seq;
	private String writer;
	private String title;
	private String regDate;
	private String content;
	
	public noticeDTO() {
		super();
	}

	public noticeDTO(String seq, String writer, String title, String regDate, String content) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.regDate = regDate;
		this.content = content;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "noticeDTO [seq=" + seq + ", writer=" + writer + ", title=" + title + ", regDate=" + regDate
				+ ", content=" + content + "]";
	}
	
	
}//class
