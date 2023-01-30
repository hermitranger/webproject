package com.example.web.model;


public interface SellOrderDAO {

	ProductDTO Sell_Product(String product_code);
	UserDTO Sell_User(String user_id);
	SellBillDTO Sell_Result(ProductDTO Pdto,String user_id,String user_phone,String user_name,String user_email,String bill_order,String sell_address,String sell_post,int bill_deliver, int bill_total);
	int CheckProduct(String product_code);
	SellBillDTO SellFail(String product_code, String user_id);
	

	
}
