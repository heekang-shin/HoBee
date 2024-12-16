package kh.pr.hobee.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class UsersVO {
	private String id, user_name, join_date, birth_date, gender,phone, user_email,
			user_pwd, lv, del_yn, social_id, social_type, id_lock, homecheck, infocheck;
	
	private int user_id;
	
}
