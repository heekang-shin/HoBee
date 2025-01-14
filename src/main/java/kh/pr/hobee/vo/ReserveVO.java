package kh.pr.hobee.vo;

public class ReserveVO {
	private int reserve_id,hb_idx,user_id,price;
	private String reserve_day;
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
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
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getReserve_day() {
		return reserve_day;
	}
	public void setReserve_day(String reserve_day) {
		this.reserve_day = reserve_day;
	}
	
	
}
