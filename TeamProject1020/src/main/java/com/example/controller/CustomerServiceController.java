package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.CsInqDTO;
import com.example.dto.FAQDTO;
import com.example.dto.FileDTO;
import com.example.dto.UserDTO;
import com.example.dto.noticeDTO;
import com.example.service.CustomerServiceService;
import com.example.service.CustomerServiceServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Controller
public class CustomerServiceController {
	@Value("${upload.path}")
	private String uploadPath; //업로드 될 폴더 경로
	
	//고객센터 메인 페이지 이동
	@Autowired
	CustomerServiceService service;
	@GetMapping("/cs")
	public String CustomerServiceMain(){
		return "CustomerService/csMain";
	}
	
	//공지사항 페이지 이동
	@GetMapping("/cs/notice")
	public ModelAndView noticeUI() {
		ModelAndView mav = new ModelAndView();
		//서비스를 통해서 api 처리한 후 jsp에서 출력만 하도록
		mav.setViewName("CustomerService/notice");
		return mav;
	}//method
	
	//공지사항 상세보기 - 넘어가기 전에 출력할 값을 받아와야한다.
	//그러려면 seq 통해서 값을 받아온다.
	@RequestMapping("/cs/noticeRetreive")
	public ModelAndView noticeRetreive(String seq,
		@RequestParam(required = false) String pageIndex,
		HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		//기본적으로 오류날 것을 가정하고 세팅해둔다.
		 mav.setViewName("redirect:notice");
		 session.setAttribute("mesg", "공지사항 오류");
		 
		 //pageIndex가 없으면 상세보기를 통해 넘어온 것이다.
		 //이 경우에는 페이지 인덱스에 해당하는 레코드 10개만 가져오는게 아니라 처음부터 찾아야한다.
		 noticeDTO dto = new noticeDTO();
		if(seq!=null)//seq가 제대로 넘어올 때만 처리
		{	
			//페이지인덱스를 통해 해당 페이지의 xml만 가져온다.
			String xmlData = "";
			
			//시퀀스 통해 검색해 noticeDTO에 넣어준다.
			
			//pageIndex가 있으면 searchSeq 사용
			if(pageIndex!=null) {
			xmlData = service.getXmlData("https://www.gogung.go.kr/openApiNoti.do?pageIndex="+pageIndex);
			dto = service.searchSeq(xmlData,seq);
			
			//pageIndex 가 없으면 내용을 키워드로 찾는 함수 재사용 (모든 xml 비교하는 단점)
			}else{
				for(int i = 1;i<=31;i++) {
					//xmlData => html(xml) 통으로 뽑아온다.(레코드 10개)
					xmlData = service.getXmlData("https://www.gogung.go.kr/openApiNoti.do?pageIndex="+i);
					//스위치문 사용 - 선택 타입으로 검색
			        	dto = service.searchSeq(xmlData, seq);
			        	//31번 동안 10개의 레코드씩 검색한다. 검색된 seq가 있으면 탈출, 없으면  
			        	if(dto.getSeq()!=null) {
			        		break;}
				}//for    
			}//else
			//dto에 결과가 잘 들어갔으면 request 통해 상세보기로 넘김
			//dto!=null 로 하면 왜 안될까?
			if(dto.getSeq()!=null) {
				//결과가 완전히 정상 완료되면 세팅한 경고 문구 삭제
				session.removeAttribute("mesg");
				mav.addObject("notice", dto);
				mav.setViewName("CustomerService/noticeRetreive");
				}//if
			}//if
		return mav;
	}//method
	
	//검색했을 경우 notice2로 넘어감.
	@RequestMapping("/cs/NtcSearchKeyWord")
	public ModelAndView searchKeyWord(String type,String keyword) {
		ModelAndView mav = new ModelAndView();
		if(keyword.length()!=0) {
			//키워드 공백 제거하고 소문자로 설정
			keyword = keyword.trim().toLowerCase();
			ArrayList<ArrayList<noticeDTO>> resultList = new ArrayList<>();
		//한번에 10개의 레코드밖에 못받으므로 다음 페이지를 명시 후 다시 요청해, 모든 레코드를 뽑는다.
		for(int pageIndex = 1;pageIndex<=31;pageIndex++) {
		//xmlData => html(xml) 통으로 뽑아온다.(레코드 10개)
		String xmlData = service.getXmlData("https://www.gogung.go.kr/openApiNoti.do?pageIndex="+pageIndex);

		//xmlData에서 타입과 같은 xml 태그의 정보만 뽑는다.
		//service.getDTO(xmlData);
		
		//스위치문 사용 - 선택 타입으로 검색
		switch (type) {	//비어있지 않을 때만 result에 저장
        case "title": 	if(!service.NtctitleSearch(xmlData, keyword).isEmpty()) {
        				resultList.add(service.NtctitleSearch(xmlData, keyword));}
        	break;
        case "content": if(!service.NtccontentSearch(xmlData, keyword).isEmpty()) {
        				resultList.add(service.NtccontentSearch(xmlData, keyword));}
            break;
        case "full": 	if(!service.NtcfullSearch(xmlData, keyword).isEmpty()) {
        				resultList.add(service.NtcfullSearch(xmlData, keyword));}
            break;
        default:
            System.out.println("cscontontroller: 올바른 옵션을 선택하지 않았습니다.");
            break;
			}//switch
		}//for
		
		
		//arraylist로 두 번 감싸진 결과를 result에 몰아 넣는다.
		ArrayList<noticeDTO> result = new ArrayList<>();
		for (ArrayList<noticeDTO> arrayList : resultList) {
			for (noticeDTO dto : arrayList) {
				result.add(dto);
			}//for
		}//for
		mav.setViewName("CustomerService/notice_search");
		mav.addObject("result", result);
		}//if - keyword가 0이 아닐때
		else {//-keyword 입력 없으면 전체 목록 보기로 돌아감
			mav.setViewName("CustomerService/notice");

		}//else
		return mav;

	}//method
	
	//자주 묻는 질문으로 이동
		@GetMapping("/cs/FAQUI")
		public ModelAndView FAQUI(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String FAQ_type
			) {
				ModelAndView mav = new ModelAndView();
				ArrayList<FAQDTO> list = null;
				list = (ArrayList)service.FAQAll();
				
				if(FAQ_type!=null) {
					list = service.FAQtypeSearch(list, FAQ_type);
			    	mav.addObject("result", list);
			    	mav.addObject("FAQ_type", FAQ_type);

				}//type에 따른 비교 완료
				
				if(keyword==null||keyword.length()==0) { //키워드 없이 전체 목록 띄워줄 때
	//					list받아온거 확인 완료
				    	mav.addObject("result", list);
				 
				  //키워드가 있을 때
				}else if(keyword!=null||keyword.length()!=0){
					if(keyword.length()!=0) {
						//키워드 공백 제거하고 소문자로 설정
						keyword = keyword.trim().toLowerCase();
						ArrayList<ArrayList<FAQDTO>> resultList = new ArrayList<>();
	
						
					//스위치문 사용 - 선택 타입으로 검색
					switch (type) {	//비어있지 않을 때만 result에 저장
			        case "title": 	
			        	if(!service.FAQtitleSearch(list, keyword).isEmpty()) {
			        				resultList.add(service.FAQtitleSearch(list, keyword));
			        		}
			        	break;
			        case "content": 
			        	if(!service.FAQcontentSearch(list, keyword).isEmpty()) {
	        				resultList.add(service.FAQcontentSearch(list, keyword));
	        				}
			        	break;
			        case "full":
			        	if(!service.FAQfullSearch(list, keyword).isEmpty()) {
						resultList.add(service.FAQfullSearch(list, keyword));
			        	}
			            break;
			        default:
			            System.out.println("csContontroller: 올바른 옵션을 선택하지 않았습니다.");
			            break;
						}//switch
					
					//검색된 값이 없다면
						//arraylist로 두 번 감싸진 결과를 result에 몰아 넣는다.
						ArrayList<FAQDTO> result = new ArrayList<>();
						for (ArrayList<FAQDTO> arrayList : resultList) {
							for (FAQDTO dto : arrayList) {
								result.add(dto);
							}//for
						}//for
						mav.addObject("result",result);

					}//if
				}//else
		  //  	
				mav.setViewName("csFAQ");
			return mav;
		}//method

		//1:1문의 내역 보기(사용자 기준)
		@GetMapping("/cs/InquiryList")
		public ModelAndView InquiryList(HttpSession session) {
			ModelAndView mav = new ModelAndView();
			UserDTO udto=(UserDTO)session.getAttribute("login");
			//회원처리
			if(udto!=null) {
				mav.setViewName("csInquiryList");
				//여기서 문의 레코드 가져온다.
				ArrayList<CsInqDTO> list = service.csInqSelectByUser(udto.getUser_no());
				if(list.size()!=0) {mav.addObject("inquiry",list);
}
			}else {
				session.setAttribute("mesg", "로그인이 필요합니다.");
				mav.setViewName("redirect:/main");
					
			}
			return mav;
		}
		
		
		//1:1 문의 글쓰기폼으로 이동
		@GetMapping("/cs/WriteInquiry")
		public ModelAndView WriteInquiry(HttpSession session) {
			ModelAndView mav = new ModelAndView();
			UserDTO udto=(UserDTO)session.getAttribute("login");
			//회원처리 if~else
			if(udto!=null) {
			mav.setViewName("csWriteInquiry");
			}else {
				session.setAttribute("mesg", "로그인이 필요합니다.");
				mav.setViewName("redirect:/main");
			}
			return mav;
		}//method
			
		//1:1 문의 글쓰기 폼에서 전달 -> 처리하는 부분
		@PostMapping("/cs/WriteInquiry")
		public ModelAndView WriteInquiryForm(
				CsInqDTO csdto,
				@RequestParam(required = false) MultipartFile[] files,
				HttpSession session, HashMap<String, Object> map
				) { //parameter
			ModelAndView mav = new ModelAndView();
			//1. 회원처리
			UserDTO udto=(UserDTO)session.getAttribute("login");
			if(udto!=null) {
				mav.setViewName("redirect:InquiryList");
				int user_no=udto.getUser_no();
				
				//2.문의 객체에 사용자 정보값 넣어주기
				csdto.setUser_no(user_no);
				csdto.setInq_state("대기");
				//3.문의 값을 db에 저장한다.
		        int n=service.csInqAdd(csdto); 
		        int inq_no = service.selectInqNo();
		        if(files!=null){
		        //4. 문의에서 첨부한 파일을 db의tb_file에 저장하는 작업
		        //파일 배열에서 파일 하나씩 꺼내가면서 한다.
		        for (MultipartFile file : files) {
		        	//files가 null 아니어도 들어간 값이 없을 수 있음
		        	//file이 진짜 없을때만 저장
		        	String originalName = file.getOriginalFilename();//모든 경로를 포함한 파일이름
					System.out.println(originalName);
		        	String fileName = originalName.substring(originalName.lastIndexOf("//") + 1); //원본 파일
				        String folderPath = makeFolder();
				        String uuid = UUID.randomUUID().toString();
				        //저장할 파일 이름 중간에 "_"를 이용하여 구분
				        String saveName = uploadPath + File.separator + folderPath +File.separator + uuid + "_" + fileName;
				        Path savePath = Paths.get(saveName);
			            //Paths.get() 메서드는 특정 경로의 파일 정보를 가져온다.(경로 정의하기)
				        String saveFileName=saveName.substring(saveName.lastIndexOf("\\")+1); //바꾼 파일 이름
				        String saveFilePath=saveName.substring(19,saveName.lastIndexOf("\\")+1); // 파일 경로         
			            try {
			                file.transferTo(savePath);
			              //  파일 db에 저장
			                FileDTO fdto=new FileDTO();
			                fdto.setFileName(fileName);
			                //게시글의 시퀀스 값
			                fdto.setSEQ_NO(inq_no);
			                fdto.setSaveFileName(saveFileName);
			                fdto.setSaveFilePath(saveFilePath);
			                fdto.setTb_type("TB_CSINQUIRY");	
			                int n1=service.addFile(fdto);
			                
			            	} catch (IOException e) {
			            		e.printStackTrace();
			            	}//catch
			        }//for
		        }//if
		        	ArrayList<FileDTO> list = service.selectFileByInqNo(inq_no);
				//회원처리 - 비회원 접근 불가
			}else {
				session.setAttribute("mesg", "로그인이 필요합니다.");
				mav.setViewName("redirect:/main");
			}
			return mav;
		}//method
		
		private String makeFolder() {
			// LocalDate를 문자열로 포멧
			String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
			String folderPath = str.replace("/",File.separator);
			// make folder ==================
			File uploadPathFoler = new File(uploadPath, folderPath);
			// File newFile= new File(dir,"파일명");
			// ->부모 디렉토리를 파라미터로 인스턴스 생성
			System.out.println(uploadPath);
			if (uploadPathFoler.exists() == false) {
				uploadPathFoler.mkdirs();
				// 만약 uploadPathFolder가 존재하지 않는다면 makeDirectory하라는 의미
				// mkdir(): 디렉토리에 상위 디렉토리가 존재하지 않을경우에는 생성이 불가능한 함수
				// mkdirs(): 디렉토리의 상위 디렉토리가 존재하지 않을 경우에는 상위 디렉토리까지 모두 생성하는 함수
			}
			return folderPath;
		}//method
		
		//비동기 - 문의 레코드 삭제 처리
		@RequestMapping("/cs/csInqDel")
		@ResponseBody
		public void csInqDel(String seq){
			//시퀀스를 기준으로 레코드를 뽑아서 삭제하면 된다.
			int inqNo = Integer.parseInt(seq);
			service.csInqDelByInqNo(inqNo);
		}//method

		
}//class
