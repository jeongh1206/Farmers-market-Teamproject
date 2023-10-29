package com.example.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.example.dto.CsInqDTO;
import com.example.dto.FAQDTO;
import com.example.dto.FileDTO;

public interface csDAO {

	List<FAQDTO> FAQAll(SqlSessionTemplate session);

	int csInqAdd(SqlSessionTemplate session,CsInqDTO csdto);

	int addFile(SqlSessionTemplate session, FileDTO fdto);
	
	ArrayList<CsInqDTO> csInqSelectByUser(SqlSessionTemplate session, int user_no);

	int selectInqNo(SqlSessionTemplate session);

	CsInqDTO csInqSelectByInqNo(int inq_no,SqlSessionTemplate session);

	ArrayList<FileDTO>selectFileByInqNo(SqlSessionTemplate session,int seq_no);

	void csInqDelByInqNo(SqlSessionTemplate session, int inqNo);

	void fileDelBySeq(SqlSessionTemplate session, int inqNo);

	List<CsInqDTO> adm_csInqAll(SqlSessionTemplate session);
	
	CsInqDTO adm_inqByInq_NO(SqlSessionTemplate session,int inq_no);

	FileDTO adm_fileByfile_No(SqlSessionTemplate session, int file_no);

	void adm_updateInqAnswer(SqlSessionTemplate session,CsInqDTO dto);

}
