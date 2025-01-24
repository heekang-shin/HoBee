package kh.pr.hobee.vo;

public class ReserveVO {
	private int reserve_id, category_num, hb_idx, user_id, price;
	private String reserve_date, hb_title, hb_date,user_name;

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getReserve_id() {
		return reserve_id;
	}

	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getHb_idx() {
		return hb_idx;
	}

	public void setHb_idx(int hb_idx) {
		this.hb_idx = hb_idx;
	}

	public int getUser_id() {
		return user_id;
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

	public String getHb_date() {
		return hb_date;
	}

	public void setHb_date(String hb_date) {
		this.hb_date = hb_date;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getReserve_date() {
		return reserve_date;
	}

	public void setReserve_date(String reserve_date) {
		this.reserve_date = reserve_date;
	}

}

