package com.example.web.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ProductDTO {
	private String product_code;
	private String filename;
	private String product_name;
	private String product_model;
	private String product_cate;
	private String product_brand;
	private int product_price;
	private int product_amount;
	private Date product_date;
	private String product_detail;
	private int product_check;
	private MultipartFile file1;
	private int product_saleprice;
	private int product_saledate;
	private int recommend;
	
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_model() {
		return product_model;
	}
	public void setProduct_model(String product_model) {
		this.product_model = product_model;
	}
	public String getProduct_cate() {
		return product_cate;
	}
	public void setProduct_cate(String product_cate) {
		this.product_cate = product_cate;
	}
	public String getProduct_brand() {
		return product_brand;
	}
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_amount() {
		return product_amount;
	}
	public void setProduct_amount(int product_amount) {
		this.product_amount = product_amount;
	}
	public Date getProduct_date() {
		return product_date;
	}
	public void setProduct_date(Date product_date) {
		this.product_date = product_date;
	}
	public String getProduct_detail() {
		return product_detail;
	}
	public void setProduct_detail(String product_detail) {
		this.product_detail = product_detail;
	}
	public int getProduct_check() {
		return product_check;
	}
	public void setProduct_check(int product_check) {
		this.product_check = product_check;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public int getProduct_saleprice() {
		return product_saleprice;
	}
	public void setProduct_saleprice(int product_saleprice) {
		this.product_saleprice = product_saleprice;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public int getProduct_saledate() {
		return product_saledate;
	}
	public void setProduct_saledate(int product_saledate) {
		this.product_saledate = product_saledate;
	}
	@Override
	public String toString() {
		return "ProductDTO [product_code=" + product_code + ", filename=" + filename + ", product_name=" + product_name
				+ ", product_model=" + product_model + ", product_cate=" + product_cate + ", product_brand="
				+ product_brand + ", product_price=" + product_price + ", product_amount=" + product_amount
				+ ", product_date=" + product_date + ", product_detail=" + product_detail + ", product_check="
				+ product_check + ", file1=" + file1 + ", product_saleprice=" + product_saleprice
				+ ", product_saledate=" + product_saledate + ", recommend=" + recommend + "]";
	}
}
