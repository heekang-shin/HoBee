package kh.pr.hobee.vo;

public class CategoryVO {
	private int category_num, bigcategory;
	private String category_name;
	
	public int getCategory_num() {
		return category_num;
	}
	public int getBigcategory() {
		return bigcategory;
	}
	public void setBigcategory(int bigcategory) {
		this.bigcategory = bigcategory;
	}
	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	
}
