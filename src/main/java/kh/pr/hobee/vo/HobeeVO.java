package kh.pr.hobee.vo;

import org.springframework.web.multipart.MultipartFile;

public class HobeeVO {
    private int hb_idx, hb_price, num_of_p, user_id, hb_tot_num, category_num;
    private String hb_title, hb_content, hb_notice, hb_date, hb_write_date,s_image;

    // MultipartFile 필드
    private MultipartFile s_image_filename; // 썸네일 이미지 파일

	public int getHb_idx() {
		return hb_idx;
	}

	public void setHb_idx(int hb_idx) {
		this.hb_idx = hb_idx;
	}

	public int getHb_price() {
		return hb_price;
	}

	public void setHb_price(int hb_price) {
		this.hb_price = hb_price;
	}

	public int getNum_of_p() {
		return num_of_p;
	}

	public void setNum_of_p(int num_of_p) {
		this.num_of_p = num_of_p;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getHb_tot_num() {
		return hb_tot_num;
	}

	public void setHb_tot_num(int hb_tot_num) {
		this.hb_tot_num = hb_tot_num;
	}

	public int getCategory_num() {
		return category_num;
	}

	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}

	public String getHb_title() {
		return hb_title;
	}

	public void setHb_title(String hb_title) {
		this.hb_title = hb_title;
	}

	public String getHb_content() {
		return hb_content;
	}

	public void setHb_content(String hb_content) {
		this.hb_content = hb_content;
	}

	public String getHb_notice() {
		return hb_notice;
	}

	public void setHb_notice(String hb_notice) {
		this.hb_notice = hb_notice;
	}

	public String getHb_date() {
		return hb_date;
	}

	public void setHb_date(String hb_date) {
		this.hb_date = hb_date;
	}

	public String getHb_write_date() {
		return hb_write_date;
	}

	public void setHb_write_date(String hb_write_date) {
		this.hb_write_date = hb_write_date;
	}

	public String getS_image() {
		return s_image;
	}

	public void setS_image(String s_image) {
		this.s_image = s_image;
	}

	public MultipartFile getS_image_filename() {
		return s_image_filename;
	}

	public void setS_image_filename(MultipartFile s_image_filename) {
		this.s_image_filename = s_image_filename;
	}

	
	


    
    

   
}
