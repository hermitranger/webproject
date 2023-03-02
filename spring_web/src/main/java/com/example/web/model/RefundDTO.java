package com.example.web.model;

public class RefundDTO {
	
	String bill_order;
	String userid;
	String token;
	String imp_uid;

	@Override
	public String toString() {
		return "RefundDTO [bill_order=" + bill_order + ", userid=" + userid + ", token=" + token + ", imp_uid="
				+ imp_uid + "]";
	}
	public String getBill_order() {
		return bill_order;
	}
	public void setBill_order(String bill_order) {
		this.bill_order = bill_order;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}


}
