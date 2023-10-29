package com.example.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.example.dto.CsInqDTO;
import com.example.dto.FAQDTO;
import com.example.dto.FileDTO;

@Repository
public class csDAOImpl implements csDAO{

	@Override
	public List<FAQDTO> FAQAll(SqlSessionTemplate session) {
		return session.selectList("FAQAll");
	}

	@Override
	public int csInqAdd(SqlSessionTemplate session, CsInqDTO csdto) {
		return session.insert("csInqAdd",csdto);
	}

	@Override
	public int addFile(SqlSessionTemplate session, FileDTO fdto) {
		return session.insert("addInqFile",fdto);
	}

	@Override
	public ArrayList<CsInqDTO> csInqSelectByUser(SqlSessionTemplate session, int user_no) {
		ArrayList<CsInqDTO> list =  null;
		list = (ArrayList)session.selectList("csInqSelectByUser",user_no);
		return list;
	}

	@Override
	public int selectInqNo(SqlSessionTemplate session) {
		return session.selectOne("selectInqNo");
	}

	@Override
	public CsInqDTO csInqSelectByInqNo(int inq_no, SqlSessionTemplate session) {
		return session.selectOne("csInqSelectByInqNo",inq_no);
	}

	@Override
	public ArrayList<FileDTO> selectFileByInqNo(SqlSessionTemplate session, int seq_no) {
		ArrayList<FileDTO> list = null;
		list = (ArrayList)session.selectList("selectFileByInqNo",seq_no);
		 return  list;
	}

	@Override
	public void csInqDelByInqNo(SqlSessionTemplate session, int inqNo) {
		session.delete("csInqDelByInqNo",inqNo);
		session.delete("fileDelBySeq",inqNo);

	}
	@Override
	public void fileDelBySeq(SqlSessionTemplate session, int inqNo) {
		session.delete("fileDelBySeq",inqNo);
	}

	@Override
	public ArrayList<CsInqDTO> adm_csInqAll(SqlSessionTemplate session) {
		ArrayList<CsInqDTO>  list = null;
		list = (ArrayList)session.selectList("adm_csInqAll");
		return list;
	}

	@Override
	public CsInqDTO adm_inqByInq_NO(SqlSessionTemplate session,int inq_no) {
		CsInqDTO  dto = null;
		dto = session.selectOne("adm_inqByInq_NO",inq_no);
		return dto;
	}

	@Override
	public FileDTO adm_fileByfile_No(SqlSessionTemplate session, int file_no) {
		FileDTO dto = null;
		dto = session.selectOne("adm_fileByfile_No",file_no);
		return dto;
	}

	@Override
	public void adm_updateInqAnswer(SqlSessionTemplate session,CsInqDTO dto) {
		session.update("adm_updateInqAnswer",dto);
	}
	
	

}
