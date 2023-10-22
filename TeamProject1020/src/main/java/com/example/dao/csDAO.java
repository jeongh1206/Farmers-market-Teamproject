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

	//나중에 다른데로 이동할수도
	int addFile(SqlSessionTemplate session, FileDTO fdto);
	
	ArrayList<CsInqDTO> csInqSelectByUser(SqlSessionTemplate session, int user_no);

	int selectInqNo(SqlSessionTemplate session);

	CsInqDTO csInqSelectByInqNo(int inq_no,SqlSessionTemplate session);

	ArrayList<FileDTO>selectFileByInqNo(SqlSessionTemplate session,int seq_no);

	void csInqDelByInqNo(SqlSessionTemplate session, int inqNo);

	void fileDelBySeq(SqlSessionTemplate session, int inqNo);

	List<CsInqDTO> csInqAll(SqlSessionTemplate session);
}
