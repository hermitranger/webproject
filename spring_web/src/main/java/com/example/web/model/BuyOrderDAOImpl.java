package com.example.web.model;



import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class BuyOrderDAOImpl implements BuyOrderDAO {


	@Autowired
	SqlSession sqlSession;
	

	
	
	@Override
	public ProductDTO Buy_Product(String product_code) {
		
		//System.out.println("DAOIMPL "+product_code);
		return sqlSession.selectOne("order.Buy_Product", product_code);
	}
	@Override
	public UserDTO Buy_User(String user_id) {
		
		return sqlSession.selectOne("order.Buy_User", user_id);
	}
	
	@Override
	public BuyBillDTO Buy_Result(ProductDTO Pdto, UserDTO Udto, String bill_order, String buy_address, String buy_post, int bill_deliver) {
		Map<String, Object> map = new HashMap<>();
		map.put("Pdto", Pdto);
		map.put("Udto", Udto);
		map.put("bill_order", bill_order);
		map.put("buy_address", buy_address);
		map.put("buy_post", buy_post);
		map.put("bill_deliver", bill_deliver);
		return sqlSession.selectOne("order.Buy_Result",map);
		
	}
	
	

}
