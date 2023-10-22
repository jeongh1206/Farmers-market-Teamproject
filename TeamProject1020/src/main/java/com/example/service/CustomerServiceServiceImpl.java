package com.example.service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.security.cert.X509Certificate;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.example.dao.csDAO;
import com.example.dto.CsInqDTO;
import com.example.dto.FAQDTO;
import com.example.dto.FileDTO;
import com.example.dto.noticeDTO;

@Service
public class CustomerServiceServiceImpl implements CustomerServiceService{
	@Autowired
	private csDAO dao;
	
	@Autowired
	private SqlSessionTemplate session;

	//순서1. open API 받아올 때 보안 인증 해제(이 메소드 안쓰면 500오류)
	   //이 메소드는 남겨주세요. open API 쓸 때 공통으로 쓸 수 있어요.
		
	@Override
    public void disableSslVerification(){
        try
        {
            // Create a trust manager that does not validate certificate chains
            TrustManager[] trustAllCerts = new TrustManager[] {new X509TrustManager() {
                public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                    return null;
                }
//                public void checkClientTrusted(X509Certificate[] certs, String authType){
//                }
                public void checkServerTrusted(X509Certificate[] certs, String authType){
                }
				@Override
				public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType)
						throws CertificateException {
				}
				@Override
				public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType)
						throws CertificateException {
				}
            }
            };

            // Install the all-trusting trust manager
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            // Create all-trusting host name verifier
            HostnameVerifier allHostsValid = new HostnameVerifier() {
                public boolean verify(String hostname, SSLSession session){
                    return true;
                }
            };

            // Install the all-trusting host verifier
            HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }
    }//method

    //순서 2.
//주소를 받아 restTemplate을 통해 외부에서 데이터를 받아온다.(원본)
//이 메소드 남겨주세요. open API 쓸 때 공통으로 쓸 수 있어요.
	@Override
public String getXmlData(String xmlUrl) {
	//ssl인증 해제
	disableSslVerification();
	
    RestTemplate restTemplate = new RestTemplate();
    ResponseEntity<String> response =
    		restTemplate.getForEntity(xmlUrl, String.class);
    //String.class: 문자열로 데이터를 받는다.
    String xmlStr = response.getBody();
    return xmlStr;
}//

//순서 3. (선택)
// xml 데이터 추출
	@Override
public ArrayList<String> getValue(String xmlData,String valueName ) {
		ArrayList<String> list = new ArrayList<String>();
		try {
		//String으로부터 xml을 읽어온다.
			Document xml  = DocumentBuilderFactory.newInstance().newDocumentBuilder().
					parse(new ByteArrayInputStream(xmlData.getBytes()));
			xml.getDocumentElement().normalize();
			
			// XML노드들을 CSS다루듯이 쉽게 다루도록 도와주는 API
			XPath xpath = XPathFactory.newInstance().newXPath();
			//xml에서 특정 노드를 선택해 list로 묶음 '//'뒤에 쓰면 된다.
			//valueName으로 지정해줘서 원하는 태그를 쉽게 바꿔서 쓸 수 있게 했다.
			
			NodeList node = (NodeList) xpath.evaluate("//"+valueName, xml, XPathConstants.NODESET);
			for (int i = 0; i < node.getLength(); i++) {
				//노드에서 값 추출
				 if(node.item(i)!=null) {
					String str = (node.item(i).getTextContent());
	 				 list.add(str);
				 }//if
			}//for
     } catch (Exception e) {
			e.printStackTrace();
		}//catch
		return list;
}//method
/////////여기까지는 xml 데이터 끌어올 때 공통으로 사용/////////////
///아래부터는 검색 기능 구현    

//제목 검색  - xmlValue를 받아서 찾고 list로 뿌림
	@Override
public ArrayList<noticeDTO> NtctitleSearch(String xmlData, String keyword){
	ArrayList<noticeDTO> list = new ArrayList<>();
	
	ArrayList<String> titlexmlValue = getValue(xmlData, "title");
	ArrayList<String> seqxmlValue = getValue(xmlData, "seq");
	ArrayList<String> writerxmlValue = getValue(xmlData, "writer");
	ArrayList<String> regDatexmlValue = getValue(xmlData, "regDate");
	
	//데이터를 받아와서 indexof를 통해 맞는지 제목과 일치하는지 돌림 -
	//일치 시 seq와 함께 dto 저장.
	//제목 : 출력용으로 dto에 저장, seq: 추후 내용 출력 시 제목에 맞는 content 찾기 위함.
	
	int i = 0;
	for (String title : titlexmlValue) {
		
		String seq = seqxmlValue.get(i);
		String writer = writerxmlValue.get(i);
		String regDate = regDatexmlValue.get(i);

		//맞을때만 dto add
		if((title.indexOf(keyword)!=-1)) {
			noticeDTO dto = new noticeDTO();
			dto.setSeq(seq);
			dto.setTitle(title);
			dto.setWriter(writer);
			dto.setRegDate(regDate);
			list.add(dto);
		}//if
		i++;
	}//for
	return list;
}//searchtitle

//내용 검색 - titleSearch와 동일. content만 추가.
@Override
public ArrayList<noticeDTO> NtccontentSearch(String xmlData, String keyword){
	ArrayList<noticeDTO> list = new ArrayList<>();
	
	ArrayList<String> titlexmlValue = getValue(xmlData, "title");
	ArrayList<String> seqxmlValue = getValue(xmlData, "seq");
	ArrayList<String> contentxmlValue = getValue(xmlData, "content");
	ArrayList<String> writerxmlValue = getValue(xmlData, "writer");
	ArrayList<String> regDatexmlValue = getValue(xmlData, "regDate");
	
	int i = 0;
	for (String content : contentxmlValue) {
		String seq = seqxmlValue.get(i);
		String title = titlexmlValue.get(i);
		String writer = writerxmlValue.get(i);
		String regDate = regDatexmlValue.get(i);
		
		//맞을때만 dto add
		if((content.indexOf(keyword)!=-1)) {
			noticeDTO dto = new noticeDTO();
			dto.setSeq(seq);
			dto.setTitle(title);
			dto.setWriter(writer);
			dto.setRegDate(regDate);
			dto.setContent(content);
			
			list.add(dto);
		}//if
		i++;
	}//for
	return list;
}//searchcontent

//전체 검색
@Override
public ArrayList<noticeDTO> NtcfullSearch(String xmlData, String keyword){
	ArrayList<noticeDTO> fullArr = new ArrayList<noticeDTO>();
	
	ArrayList<noticeDTO> titleArr = NtctitleSearch(xmlData,keyword);
	ArrayList<noticeDTO> contentArr = NtccontentSearch(xmlData,keyword);
	
	//일단 content을 기준으로 arr을 다 집어넣고 만약에 titleArr과 seq가 겹치지 않을떄만 추가로 dto를 넣는다.
	for (noticeDTO cdto : contentArr) {
		fullArr.add(cdto);
	}
	//titleArr을 집어넣으려고 하는데  이미 들어간 배열과 비교해서 없을때만 들어감
	//fullArr을 foreach돌리면서 그 안에서 바로 fullArr에 add하려고하면 오류난다.
	for (noticeDTO tdto : titleArr) {
		boolean check = false;
		for (noticeDTO fdto : fullArr) {
			if(fdto.getSeq().equals(tdto.getSeq())) {
				check = true;
				break;
			}//if
		}//for
			if(!check) {
				fullArr.add(tdto);
			}//if
    	}//for
	return fullArr;
}//method

//시퀀스를 통해 공지 레코드 찾는 메소드 (selectOne의 기능과 비슷)
@Override
public noticeDTO searchSeq(String xmlData, String seq) {
	noticeDTO dto = new noticeDTO();
	ArrayList<String> seqList = getValue(xmlData, "seq");
    	int index=0;
    	String seq2 = "";
    	//한 페이지 - 10개의 레코드에서 seq 배열을 받아서 같은 seq의 index를 찾는다.
		for (String s : seqList) {
			if(seq.equals(s)){
				seq2 = s;
				break;
			}//if	
			index++;
		}//for
		
	//일치하는 시퀀스가 있을 경우
	if(seq.equals(seq2)) {
	String writer = getValue(xmlData, "writer").get(index);
	String title = getValue(xmlData, "title").get(index);
	String regDate = getValue(xmlData, "regDate").get(index);
	regDate = regDate.substring(0,10);
	String content = getValue(xmlData, "content").get(index);
	
	dto.setSeq(seq2);
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setRegDate(regDate);
	dto.setContent(content);
	
	}//if
	return dto;
}
@Override
public ArrayList<FAQDTO> FAQAll() {
	return (ArrayList<FAQDTO>) dao.FAQAll(session);
}

  
//내용 검색 - titleSearch와 동일. content만 추가.
@Override
public ArrayList<FAQDTO> FAQcontentSearch(ArrayList<FAQDTO> list, String keyword){
	ArrayList<FAQDTO> result = new ArrayList<>();
	
	//전체 리스트에서 dto를 하나씩 꺼내면서
	int i = 0;
	for (FAQDTO dto : list) {
		//맞을때만 dto add
		if((dto.getFAQ_content().indexOf(keyword)!=-1)) {
			result.add(dto);
		}//if
		i++;
	}//for
	return result;
	
}//searchcontent
//내용 검색 - titleSearch와 동일. content만 추가.
@Override
public ArrayList<FAQDTO> FAQtitleSearch(ArrayList<FAQDTO> list, String keyword){
	ArrayList<FAQDTO> result = new ArrayList<>();
	
	//전체 리스트에서 dto를 하나씩 꺼내면서
	int i = 0;
	for (FAQDTO dto : list) {
		//맞을때만 dto add
		if((dto.getFAQ_title().indexOf(keyword)!=-1)) {
			result.add(dto);
		}//if
		i++;
	}//for
	return result;
}//searchcontent

@Override
public ArrayList<FAQDTO> FAQfullSearch(ArrayList<FAQDTO> list, String keyword){
	ArrayList<FAQDTO> fullArr = new ArrayList<FAQDTO>();
	
	ArrayList<FAQDTO> titleArr = FAQtitleSearch(list,keyword);
	ArrayList<FAQDTO> contentArr = FAQcontentSearch(list,keyword);
	
	//일단 content을 기준으로 arr을 다 집어넣고 만약에 titleArr과 seq가 겹치지 않을떄만 추가로 dto를 넣는다.
	for (FAQDTO cdto : contentArr) {
		fullArr.add(cdto);
	}
	//titleArr을 집어넣으려고 하는데  이미 들어간 배열과 비교해서 없을때만 들어감
	//fullArr을 foreach돌리면서 그 안에서 바로 fullArr에 add하려고하면 오류난다.
	for (FAQDTO tdto : titleArr) {
		boolean check = false;
		for (FAQDTO fdto : fullArr) {
			if(fdto.getFAQ_no().equals(tdto.getFAQ_no())) {
				check = true;
				break;
			}//if
		}//for
			if(!check) {
				fullArr.add(tdto);
			}//if
    	}//for
	return fullArr;
}//method

@Override
public ArrayList<FAQDTO> FAQtypeSearch(ArrayList<FAQDTO> list, String FAQ_type){
	ArrayList<FAQDTO> result = new ArrayList<>();
	//전체 리스트에서 dto를 하나씩 꺼내면서
	int i = 0;
	for (FAQDTO dto : list) {
		//맞을때만 dto add
		if((dto.getFAQ_type().indexOf(FAQ_type)!=-1)) {
			result.add(dto);
			}//if
			i++;
		}//for
		return result;
	}//searchtype

@Override
public int csInqAdd(CsInqDTO csdto) {
	return dao.csInqAdd(session,csdto);
	}

@Override
public int addFile(FileDTO fdto) {
	return dao.addFile(session,fdto);
}

@Override
public ArrayList<CsInqDTO> csInqSelectByUser(int user_no) {
	return dao.csInqSelectByUser(session, user_no);
}

@Override
public int selectInqNo() {
	return dao.selectInqNo(session);
}

@Override
public CsInqDTO csInqSelectByInqNo(int inq_no) {
	return dao.csInqSelectByInqNo(inq_no, session);
}

@Override
public ArrayList<FileDTO> selectFileByInqNo(int inq_no) {
	return dao.selectFileByInqNo(session, inq_no);
}

@Override
public void csInqDelByInqNo(int inqNo) {
	dao.csInqDelByInqNo(session,inqNo);
}
@Override
public void fileDelBySeq(int inqNo) {
	dao.fileDelBySeq(session,inqNo);
}

@Override
public List<CsInqDTO> csInqAll() {
	List<CsInqDTO> list = dao.csInqAll(session);
	return list;
}
}//class

