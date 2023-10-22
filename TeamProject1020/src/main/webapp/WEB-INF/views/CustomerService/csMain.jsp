<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!--부트 스트랩 css-->
	<link type = "text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!--부트 스트랩 js-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="resources/css/csMain.css"/>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

</head>
<body>   
<jsp:include page="../common/top.jsp" flush="true"/> <br>
         <div style="height:60px"></div>
         <jsp:include page="csMenu.jsp" flush="true"/> <br>
         
        <div class="col-sm-8 divCsMain">
        <!-- //////////여기까진 공통적으로 들어감 -->
        	
            <p class="textTitle col-sm-12">
              	  고객센터
            </p>
            <br><br>
            <div class="divCsInfo">
                <div class="infoText">
                    <p>
                        Customer Center
                    </p>
                    <p class="textBold">
                        080.011.0222 /070.0111.0222	
                    </p>
                    <p>
                        평일 08:30 ~ 17:30, 점심 12:30 ~ 13:30 (토/일요일 및 공휴일 휴무)
                    </p>
                    <br><br>
                </div>
                <br>
             	
            </div><!--divCsInfo-->
            <div class="row csImgList" >
            <div class="col-md-2"></div>
             <div class="col-md-2 csImg" onclick="location.href='/app/cs/notice'">
                    <div class="innerDivimg">
                     <!--공지사항 아이콘 코드-->
                     <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-journal-check" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M10.854 6.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 8.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                        <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                        <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                      </svg>
                     <br>
                     <span>
                         공지사항
                     </span>
                     </div>
                 </div> 
                 <div class="col-md-2 csImg" onclick="location.href='/app/cs/FAQUI'">
                    <div class="innerDivimg">
                        <!--faq 아이콘 코드-->
                        <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-question-square" viewBox="0 0 16 16">
                            <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                            <path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
                        </svg>
                        <br>
                        <span>
                        FAQ
                        </span>
                    </div>
                 </div> 
                 <div class="col-md-2 csImg" onclick="location.href='/app/cs/InquiryList'">
                    <div class="innerDivimg">
                     <!--1:1문의 아이콘 코드-->
                        <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                        </svg>
                        <br>
                        <span>
                            1:1문의
                        </span>
                     </div>
                 </div>
            </div><!--csImg-->
            <div class="FAQBest">
                <p class="textTitle">
                    자주 묻는 질문 BEST
                    </p>
                    <br>
                    <div class="accordion" id="accordionExample">
                        <div class="accordion-item">
                          <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button csMain" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                               <strong>Q</strong>&ensp;배송받을 주소를 변경하려면 어떻게 해야 하나요?
                            </button>
                          </h2>
                          <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                A 1. [주문접수/결제완료] 단계 <br>
                                - 배송지 직접 변경 : 마이페이지>쇼핑정보>주문상세내역<br>
                                - 직접 취소 후 재주문 : 직접 취소는 마이페이지>쇼핑정보>주문내역 가능 (취소와 동시에 결제 취소).<br>
                                - 고객센터 (080.011.0222 /070.0111.0222	)로 요청<br>
                                단, 고객센터 운영시간 내 요청하셔야 합니다.<br>
                                (평일 : 17시 30분 - 토/일요일,공휴일은 미운영)<br>
                                <br>
                                
                                2. [배송준비중] 단계에서는 이미 출고준비가 완료된 상태로 변경해 드릴 수 없사오니 양해 바랍니다.<br>
                                [배송준비중] 단계에서 주소변경 사유로 취소하실 경우 배송비는 고객님 부담입니다.
                                <br> 환불 시 배송비가 차감된 후 잔액을 환불받게 됩니다.                            </div>
                          </div>
                        </div>
                        <div class="accordion-item">
                          <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed csMain" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                <strong>Q</strong> 배송일 지정은 가능한가요?
                            </button>
                          </h2>
                          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                A 선택가능한 도착 희망일은 주문서 작성 시 확인하실 수 있습니다.
                            </div>
                          </div>
                        </div>
                        <div class="accordion-item">
                          <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed csMain" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                <strong>Q</strong> 주문 후 배송조회는 어떻게 하나요?
                            </button>
                          </h2>
                          <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                               A [로그인] 후 → [마이페이지] → [쇼핑정보] → [주문내역]을 통해 주문별로 송장번호 및 진행상황을 확인하실 수 있습니다. 
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--FAQBest-->
            <br>
            <div class="FAQList">
                <button type="button" class="col-sm-10 btn btn-success FAQList">
                	<a href="/app/cs/FAQUI">전체보기</a>
                </button>
            </div>
        </div><!--csMain row-->
    </div><!--csBody row-->
	<jsp:include page="../common/bottom.jsp" flush="true"/> <br>
</body>
</html>