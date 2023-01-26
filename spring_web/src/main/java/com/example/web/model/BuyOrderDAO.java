package com.example.web.model;


public interface BuyOrderDAO {

	ProductDTO Buy_Product(String product_code);
	UserDTO Buy_User(String user_id);
	BuyBillDTO Buy_Result(ProductDTO Pdto, UserDTO Udto, String bill_order, String buy_address, String  buy_post, int bill_deliver);
	
}
