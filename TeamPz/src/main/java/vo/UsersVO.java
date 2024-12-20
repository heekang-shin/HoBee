package vo;

public class UsersVO {
	// int 타입 필드 (NUMBER 데이터 타입에 해당)
	private int userId;

	// String 타입 필드 (VARCHAR2, DATE 데이터 타입에 해당)
	private String id;
	private String username;
	private String joindate; // DATE는 String으로 처리, 필요 시 Date 객체로 변환
	private String birthdate; // DATE는 String으로 처리, 필요 시 Date 객체로 변환
	private String gender;
	private String phone;
	private String useremail;
	private String userpwd;
	private String lv;
	private String delYn;
	private String socialId;
	private String socialType;
	private String idlock;
	private String homecheck;
	private String nickname;
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	private boolean phoneVerified; //인증번호 받을 컬럼 
	public boolean isPhoneVerified() {
		return phoneVerified;
	}
	public void setPhoneVerified(boolean phoneVerified) {
		this.phoneVerified = phoneVerified;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
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
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public String getLv() {
		return lv;
	}
	public void setLv(String lv) {
		this.lv = lv;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getSocialId() {
		return socialId;
	}
	public void setSocialId(String socialId) {
		this.socialId = socialId;
	}
	public String getSocialType() {
		return socialType;
	}
	public void setSocialType(String socialType) {
		this.socialType = socialType;
	}
	public String getIdlock() {
		return idlock;
	}
	public void setIdlock(String idlock) {
		this.idlock = idlock;
	}
	public String getHomecheck() {
		return homecheck;
	}
	public void setHomecheck(String homecheck) {
		this.homecheck = homecheck;
	}
	
}


