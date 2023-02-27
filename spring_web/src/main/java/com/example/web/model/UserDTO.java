package com.example.web.model;

public class UserDTO {
	private String user_id;
	private String user_passwd;
	private String user_name;
	private String user_birth;
	private String user_gender;
	private String user_email;
	private String user_phone;
	private String user_addr;
	private String user_addrdetail;
	private String user_zipcode;
	private int user_check;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_passwd() {
		return user_passwd;
	}
	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public String getUser_addrdetail() {
		return user_addrdetail;
	}
	public void setUser_addrdetail(String user_addrdetail) {
		this.user_addrdetail = user_addrdetail;
	}
	public String getUser_zipcode() {
		return user_zipcode;
	}
	public void setUser_zipcode(String user_zipcode) {
		this.user_zipcode = user_zipcode;
	}
	public int getUser_check() {
		return user_check;
	}
	public void setUser_check(int user_check) {
		this.user_check = user_check;
	}
	@Override
	public String toString() {
		return "UserDTO [user_id=" + user_id + ", user_passwd=" + user_passwd + ", user_name=" + user_name
				+ ", user_birth=" + user_birth + ", user_gender=" + user_gender + ", user_email=" + user_email
				+ ", user_phone=" + user_phone + ", user_addr=" + user_addr + ", user_addrdetail=" + user_addrdetail
				+ ", user_zipcode=" + user_zipcode + ", user_check=" + user_check + "]";
	}
	
	
	
	
}
