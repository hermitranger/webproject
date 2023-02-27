package com.example.web.model;

public class DealDTO {
	String product_code;
	int product_price;
	int product_saleprice;
	int count;
	double sale;
	int sum_price;//개별 총계
	String product_name; 
	int total_price;//총 
	int total_count;//총 
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_saleprice() {
		return product_saleprice;
	}
	public void setProduct_saleprice(int product_saleprice) {
		this.product_saleprice = product_saleprice;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getSale() {
		return sale;
	}
	public void setSale(double sale) {
		this.sale = sale;
	}
	public int getSum_price() {
		return sum_price;
	}
	public void setSum_price(int sum_price) {
		this.sum_price = sum_price;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getTotal_count() {
		return total_count;
	}
	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}
	@Override
	public String toString() {
		return "DealDTO [product_code=" + product_code + ", product_price=" + product_price + ", product_saleprice="
				+ product_saleprice + ", count=" + count + ", sale=" + sale + ", sum_price=" + sum_price
				+ ", product_name=" + product_name + ", total_price=" + total_price + ", total_count=" + total_count
				+ "]";
	}
	
	


}
