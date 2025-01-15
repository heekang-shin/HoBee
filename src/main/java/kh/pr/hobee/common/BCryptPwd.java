package kh.pr.hobee.common;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptPwd {

	//암호화 메서드 
	public String encryption(String user_pwd) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePwd = encoder.encode(user_pwd);
		return encodePwd;
				
	}
	
	//복호화 메서드
	public boolean decryption(String encodePwd, String user_pwd) {
		boolean isValid = false;
		
		//BCrpyt.checkpwd(입력한 비번, 암호화된 비번);
		isValid = BCrypt.checkpw(user_pwd, encodePwd);
		
		return isValid;
		
	}
	
	
	
}


