package util;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptPwd {
	
	//암호화 메서드
	public String encryption( String pwd ) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePwd = encoder.encode(pwd);
		return encodePwd;
	}
	
	//복호화 메서드
	public boolean decryption( String encodePwd, String pwd ) {
		boolean isValid = false;
		//복호화 인듯 하지만 실제는 DB에 있는 암호화된 비밀번호를 갖고와서 입력된 비밀번호랑 비교하는 코드에 가까움
		//BCrypt 자체가 단방향 암호화 알고리즘임
		//BCrypt.checkpw(입력한 비번, 암호화 된 비번);
		isValid = BCrypt.checkpw(pwd, encodePwd);
		
		return isValid;
	}
	
}












