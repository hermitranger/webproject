package com.example.web.model;

import java.util.Date;

public class SellBillDTO {
	
	private String bill_order;
	private String s_code;
	private String sell_id;
	private String s_name;
	private Date bill_date;
	private int s_price;
	private int s_check;
	private int bill_deliver;
	private int bill_total;
	private String sell_address;
	private String sell_addressdetail;
	private String sell_post;
	private String s_cate;
	private String impUid;
	private String s_progress;
	public String getBill_order() {
		return bill_order;
	}
	public void setBill_order(String bill_order) {
		this.bill_order = bill_order;
	}
	public String getS_code() {
		return s_code;
	}
	public void setS_code(String s_code) {
		this.s_code = s_code;
	}
	public String getSell_id() {
		return sell_id;
	}
	public void setSell_id(String sell_id) {
		this.sell_id = sell_id;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public Date getBill_date() {
		return bill_date;
	}
	public void setBill_date(Date bill_date) {
		this.bill_date = bill_date;
	}
	public int getS_price() {
		return s_price;
	}
	public void setS_price(int s_price) {
		this.s_price = s_price;
	}
	public int getS_check() {
		return s_check;
	}
	public void setS_check(int s_check) {
		this.s_check = s_check;
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
	public String getSell_address() {
		return sell_address;
	}
	public void setSell_address(String sell_address) {
		this.sell_address = sell_address;
	}
	public String getSell_addressdetail() {
		return sell_addressdetail;
	}
	public void setSell_addressdetail(String sell_addressdetail) {
		this.sell_addressdetail = sell_addressdetail;
	}
	public String getSell_post() {
		return sell_post;
	}
	public void setSell_post(String sell_post) {
		this.sell_post = sell_post;
	}
	public String getS_cate() {
		return s_cate;
	}
	public void setS_cate(String s_cate) {
		this.s_cate = s_cate;
	}
	public String getImpUid() {
		return impUid;
	}
	public void setImpUid(String impUid) {
		this.impUid = impUid;
	}
	public String getS_progress() {
		return s_progress;
	}
	public void setS_progress(String s_progress) {
		this.s_progress = s_progress;
	}
	@Override
	public String toString() {
		return "SellBillDTO [bill_order=" + bill_order + ", s_code=" + s_code + ", sell_id=" + sell_id + ", s_name="
				+ s_name + ", bill_date=" + bill_date + ", s_price=" + s_price + ", s_check=" + s_check
				+ ", bill_deliver=" + bill_deliver + ", bill_total=" + bill_total + ", sell_address=" + sell_address
				+ ", sell_addressdetail=" + sell_addressdetail + ", sell_post=" + sell_post + ", s_cate=" + s_cate
				+ ", impUid=" + impUid + ", s_progress=" + s_progress + "]";
	}
	
	
	
	
}
