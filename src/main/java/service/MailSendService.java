package service;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailSendService {

	private JavaMailSender javaMailSender;
	private int authNumber = 0;
	
	public MailSendService( JavaMailSender javaMailSender ) {
		this.javaMailSender = javaMailSender;
	}
	
	//인증번호 생성 메서드
	public void makeRandomNumber() {
		authNumber = new Random().nextInt(999999 - 111111 + 1) + 111111;
		System.out.println("인증번호 : " + authNumber);
	}
	
	//이메일 양식
	public String joinEmail( String email ) {
		makeRandomNumber();
		
		String setFrom = "ae097709@naver.com";//보내는 사람의 메일주소
		String toMail = email;//받을사람의 메일주소
		
		String title =  "이메일 인증 입니다.";
		
		String content = "인증번호는<b> " + authNumber + "</b>입니다";
		
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = 
					new MimeMessageHelper(mail, true, "utf-8");
			
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content,true);
			
			javaMailSender.send(mail);
		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return "" + authNumber;
		
	}
	
}