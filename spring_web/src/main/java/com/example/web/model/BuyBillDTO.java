package com.example.web.model;

import java.util.Date;

public class BuyBillDTO {
	private String bill_order;
	private String b_code;
	private String buy_id;
	private String b_name;
	private Date bill_date;
	private int b_price;
	private int b_check;
	private int bill_deliver;
	private int bill_total;
	private String buy_address;
	private String buy_addressdetail;
	private String buy_post;
	private String b_cate;
	public String getBill_order() {
		return bill_order;
	}
	public void setBill_order(String bill_order) {
		this.bill_order = bill_order;
	}
	public String getb_code() {
		return b_code;
	}
	public void setb_code(String b_code) {
		this.b_code = b_code;
	}
	public String getbuy_id() {
		return buy_id;
	}
	public void setbuy_id(String buy_id) {
		this.buy_id = buy_id;
	}
	public String getb_name() {
		return b_name;
	}
	public void setb_name(String b_name) {
		this.b_name = b_name;
	}
	public Date getBill_date() {
		return bill_date;
	}
	public void setBill_date(Date bill_date) {
		this.bill_date = bill_date;
	}
	public int getb_price() {
		return b_price;
	}
	public void setb_price(int b_price) {
		this.b_price = b_price;
	}
	public int getb_check() {
		return b_check;
	}
	public void setb_check(int b_check) {
		this.b_check = b_check;
	}
	public int getBill_deliver() {
		return bill_deliver;
	}
	public void setBill_deliver(int bill_deliver) {
		this.bill_deliver = bill_deliver;
	}
	public int getBill_total() {
		return bill_total;
	}
	public void setBill_total(int bill_total) {
		this.bill_total = bill_total;
	}
	public String getBuy_address() {
		return buy_address;
	}
	public void setBuy_address(String buy_address) {
		this.buy_address = buy_address;
	}
	public String getBuy_addressdetail() {
		return buy_addressdetail;
	}
	public void setBuy_addressdetail(String buy_addressdetail) {
		this.buy_addressdetail = buy_addressdetail;
	}
	public String getBuy_post() {
		return buy_post;
	}
	public void setBuy_post(String buy_post) {
		this.buy_post = buy_post;
	}
	public String getB_cate() {
		return b_cate;
	}
	public void setB_cate(String b_cate) {
		this.b_cate = b_cate;
	}
	@Override
	public String toString() {
		return "BuyBillDTO [bill_order=" + bill_order + ", b_code=" + b_code + ", buy_id=" + buy_id + ", b_name="
				+ b_name + ", bill_date=" + bill_date + ", b_price=" + b_price + ", b_check=" + b_check
				+ ", bill_deliver=" + bill_deliver + ", bill_total=" + bill_total + ", buy_address=" + buy_address
				+ ", buy_addressdetail=" + buy_addressdetail + ", buy_post=" + buy_post + ", b_cate=" + b_cate + "]";
	}
	
}
