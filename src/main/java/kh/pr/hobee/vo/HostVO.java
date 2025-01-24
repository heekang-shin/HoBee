package kh.pr.hobee.vo;

import org.springframework.web.multipart.MultipartFile;

public class HostVO {
	private String host_name, host_info, host_img, id, phone, user_email, user_name, lv;
	private int user_id, approval;
	
	
	public String getLv() {
		return lv;
	}
	public void setLv(String lv) {
		this.lv = lv;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	private MultipartFile host_image_filename;

	
	public MultipartFile getHost_image_filename() {
		return host_image_filename;
	}
	public void setHost_image_filename(MultipartFile host_image_filename) {
		this.host_image_filename = host_image_filename;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getHost_name() {
		return host_name;
	}
	public void setHost_name(String host_name) {
		this.host_name = host_name;
	}
	public String getHost_info() {
		return host_info;
	}
	public void setHost_info(String host_info) {
		this.host_info = host_info;
	}
	public String getHost_img() {
		return host_img;
	}
	public void setHost_img(String host_img) {
		this.host_img = host_img;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getApproval() {
		return approval;
	}
	public void setApproval(int approval) {
		this.approval = approval;
	}
	
	
}