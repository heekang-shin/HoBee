package kh.pr.hobee.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class UsersVO {

	// int 타입 필드 (NUMBER 데이터 타입에 해당)
	private int user_Id;

	// String 타입 필드 (VARCHAR2, DATE 데이터 타입에 해당)
	private String id;
	private String user_name;
	private String join_date; // DATE는 String으로 처리, 필요 시 Date 객체로 변환
	private String birth_date; // DATE는 String으로 처리, 필요 시 Date 객체로 변환
	private String gender;
	private String phone;
	private String user_email;
	private String user_pwd;
	private String lv;
	private String del_Yn;
	private String social_Id;
	private String social_Type;
	private String id_lock;
	private String homecheck;
	private String nick_name;
	private String pwd_change;//염지연

	public String getPwd_change() {
		return pwd_change;
	}

	public void setPwd_change(String pwd_change) {
		this.pwd_change = pwd_change;
	}

	public String getSocial_Id() {
		return social_Id;
	}

	public void setSocial_Id(String social_Id) {
		this.social_Id = social_Id;
	}

	public int getUser_Id() {
		return user_Id;
	}

	public void setUser_Id(int user_Id) {
		this.user_Id = user_Id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getBirth_date() {
		return birth_date;
	}

	public void setBirth_date(String birth_date) {
		this.birth_date = birth_date;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getLv() {
		return lv;
	}

	public void setLv(String lv) {
		this.lv = lv;
	}

	public String getDel_Yn() {
		return del_Yn;
	}

	public void setDel_Yn(String del_Yn) {
		this.del_Yn = del_Yn;
	}


	public String getSocial_Type() {
		return social_Type;
	}

	public void setSocial_Type(String social_Type) {
		this.social_Type = social_Type;
	}

	public String getId_lock() {
		return id_lock;
	}

	public void setId_lock(String id_lock) {
		this.id_lock = id_lock;
	}

	public String getHomecheck() {
		return homecheck;
	}

	public void setHomecheck(String homecheck) {
		this.homecheck = homecheck;
	}

	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
}
