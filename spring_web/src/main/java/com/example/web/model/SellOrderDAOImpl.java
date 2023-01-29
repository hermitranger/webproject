package com.example.web.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SellOrderDAOImpl implements SellOrderDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public ProductDTO Sell_Product(String product_code) {
		return sqlSession.selectOne("order.Sell_Product", product_code);
	}
	
	@Override
	public UserDTO Sell_User(String user_id) {
		
		return sqlSession.selectOne("order.Sell_User", user_id);
	}

	

	@Override
	public SellBillDTO Sell_Result(ProductDTO Pdto,String user_id,String user_phone,String user_name,String user_email,String bill_order,String sell_address,String sell_post,int bill_deliver,int bill_total) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("Pdto", Pdto);
		//여기부터 시작 들어갈거 다 맵에 넣어야함
		map.put("user_id",user_id);
		map.put("user_phone",user_phone);
		map.put("user_name",user_name);
		map.put("user_email",user_email);
		map.put("bill_order", bill_order);
		map.put("sell_address", sell_address);
		map.put("sell_post", sell_post);
		map.put("bill_deliver", bill_deliver);
		map.put("bill_total", bill_total);
		
		return sqlSession.selectOne("order.Sell_Result",map);
		
	}

	@Override
	public int CheckProduct(String product_code) {
		return sqlSession.selectOne("order.CheckProduct", product_code);	
	}
	
	public SellBillDTO SellFail(String product_code, String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("s_code", product_code);
		map.put("sell_id", user_id);
		System.out.println("SellBillDaoimpl " + product_code);
		System.out.println("SellBillDaoimpl " + user_id);
		
		return sqlSession.selectOne("order.SellFail",map);	
	
	}

	
}
