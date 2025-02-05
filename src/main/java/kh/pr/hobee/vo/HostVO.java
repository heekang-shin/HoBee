package kh.pr.hobee.vo;

import org.springframework.web.multipart.MultipartFile;

public class HostVO {
	private String host_name, host_info, host_img;
	private int user_id, approval;
	
	private MultipartFile host_image_filename;

	
	public MultipartFile getHost_image_filename() {
		return host_image_filename;
	}
	public void setHost_image_filename(MultipartFile host_image_filename) {
		this.host_image_filename = host_image_filename;
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
