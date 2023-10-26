package com.example.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.example.dto.CsInqDTO;
import com.example.dto.FAQDTO;
import com.example.dto.FileDTO;
import com.example.dto.noticeDTO;

public interface CustomerServiceService {
    public void disableSslVerification();
    public String getXmlData(String xmlUrl);
    public ArrayList<String> getValue(String xmlData,String valueName);
    public ArrayList<noticeDTO> NtctitleSearch(String xmlData, String keyword);
    public ArrayList<noticeDTO> NtccontentSearch(String xmlData, String keyword);
    public ArrayList<noticeDTO> NtcfullSearch(String xmlData, String keyword);
    public noticeDTO searchSeq(String xmlData, String seq);
	public ArrayList<FAQDTO> FAQAll();
    public ArrayList<FAQDTO> FAQcontentSearch(ArrayList<FAQDTO> list, String keyword);
    public ArrayList<FAQDTO> FAQtitleSearch(ArrayList<FAQDTO> list, String keyword);
    public ArrayList<FAQDTO> FAQfullSearch(ArrayList<FAQDTO> list, String keyword);
    public ArrayList<FAQDTO> FAQtypeSearch(ArrayList<FAQDTO> list, String FAQ_type);
    public int csInqAdd(CsInqDTO csdto);
	public int addFile(FileDTO fdto);
	public ArrayList<CsInqDTO> csInqSelectByUser(int user_no);
	public int selectInqNo();
    public CsInqDTO csInqSelectByInqNo(int inq_no);
    public ArrayList<FileDTO> selectFileByInqNo(int inq_no);
	public void csInqDelByInqNo(int inqNo);
	public void fileDelBySeq(int inqNo);
	public List<CsInqDTO> adm_csInqAll();
	public CsInqDTO adm_inqByInq_NO(int inq_no);
	
	

}
