package com.example.service;

import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService{
	 
		@Autowired
		JavaMailSender emailSender;
		

	  	//ePw: 인증코드
//	    public static final String ePw = createKey();
	    public String ePw = createKey();
	 
	    private MimeMessage createMessage(String to)throws Exception{
	        ePw = createKey();
	    	//System.out.println("보내는 대상 : "+ to);
	       // System.out.println("인증 번호 : "+ePw);
	        MimeMessage  message = emailSender.createMimeMessage();
	 
	        message.addRecipients(RecipientType.TO, to);//보내는 대상
	        message.setSubject("farmer's market 이메일 인증");//제목
	 
	        String msgg="";
	        msgg+= "<div style='margin:100px;'>";
	        msgg+= "<h1> 안녕하세요 파머스 마켓입니다. </h1>";
	        msgg+= "<br>";
	        msgg+= "<p>아래 코드를 입력해주세요<p>";
	        msgg+= "<br>";
	        msgg+= "<p>감사합니다!<p>";
	        msgg+= "<br>";
	        msgg+= "<div align='center' style='border:1px solid black; font-family:verdana';>";
	        msgg+= "<h3 style='color:blue;'> 인증 코드입니다.</h3>";
	        msgg+= "<div style='font-size:130%'>";
	        msgg+= "CODE : <strong>";
	        msgg+= ePw+"</strong><div><br/> ";
	        msgg+= "</div>";
	        message.setText(msgg, "utf-8", "html");//내용
	        message.setFrom(new InternetAddress("fortestemail0904@gmail.com","farmer's market"));//보내는 사람
	 
	        return message;
	    }
	 
	    //인증 코드 생성
//	    public static String createKey() {
	    public String createKey() {
	        StringBuffer key = new StringBuffer();
	        Random rnd = new Random();
	 
	        for (int i = 0; i < 8; i++) { // 인증코드 8자리
	            int index = rnd.nextInt(6); // 0~2 까지 랜덤
	 
	            switch (index) {
	                case 0:
	                    key.append((char) ((int) (rnd.nextInt(26)) + 97));
	                    //  a~z  (ex. 1+97=98 => (char)98 = 'b')
	                    break;
	                case 1:
	                    key.append((char) ((int) (rnd.nextInt(26)) + 65));
	                    //  A~Z
	                    break;
	                case 2: key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    //  A~Z
                    break;
	                case 3: key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    //  A~Z
                    break;
	                case 4: key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    //  A~Z
                    break;
	                case 5: key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    //  A~Z
                    break;
	            }
	        }
	 
	        return key.toString();
	    }
	    //이메일 보내기
	    @Override
	    public String sendSimpleMessage(String to)throws Exception {
	        //이메일 내용 담기
	    	MimeMessage message = createMessage(to);
	        try{
	        	//이메일 내용 전송
	            emailSender.send(message);
	        }catch(MailException es){
	            es.printStackTrace();
	            throw new IllegalArgumentException();
	        }
	        return ePw;
	    }//method



}//class

