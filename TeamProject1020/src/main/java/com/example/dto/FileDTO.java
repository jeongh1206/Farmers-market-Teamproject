package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("FileDTO")
public class FileDTO {
	private int FILE_NO;
	private int SEQ_NO; //원 게시글의 시퀀스 번호
	private String fileName; //원본 파일 이름
	private String saveFileName; //저장된 파일 이름
	private String saveFilePath; //파일 경로
	private String tb_type; //원 게시글 테이블 이름
	
	
	public FileDTO() {
		super();
	}
	public FileDTO(int fILE_NO, int sEQ_NO, String fileName, String saveFileName, String saveFilePath, String tb_type) {
		super();
		FILE_NO = fILE_NO;
		SEQ_NO = sEQ_NO;
		this.fileName = fileName;
		this.saveFileName = saveFileName;
		this.saveFilePath = saveFilePath;
		this.tb_type = tb_type;
	}
	public int getFILE_NO() {
		return FILE_NO;
	}
	public void setFILE_NO(int fILE_NO) {
		FILE_NO = fILE_NO;
	}
	public int getSEQ_NO() {
		return SEQ_NO;
	}
	public void setSEQ_NO(int sEQ_NO) {
		SEQ_NO = sEQ_NO;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getSaveFilePath() {
		return saveFilePath;
	}
	public void setSaveFilePath(String saveFilePath) {
		this.saveFilePath = saveFilePath;
	}
	public String getTb_type() {
		return tb_type;
	}
	public void setTb_type(String tb_type) {
		this.tb_type = tb_type;
	}
	@Override
	public String toString() {
		return "FileDTO [FILE_NO=" + FILE_NO + ", SEQ_NO=" + SEQ_NO + ", fileName=" + fileName + ", saveFileName="
				+ saveFileName + ", saveFilePath=" + saveFilePath + ", tb_type=" + tb_type + "]";
	}
}