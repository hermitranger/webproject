package com.example.web.model;

public class CartDTO {
	
	String user_id;
	String product_code;
	int price;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "CartDTO [user_id=" + user_id + ", product_code=" + product_code + ", price=" + price + "]";
	}


}
