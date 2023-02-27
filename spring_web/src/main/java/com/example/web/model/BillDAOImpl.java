package com.example.web.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BillDAOImpl implements BillDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<BuyBillDTO> buy_deal() {
		return sqlSession.selectList("deal.buy_deal");
	}
	
	@Override
	public List<SellBillDTO> sell_deal() {
		return sqlSession.selectList("deal.sell_deal");
	}
	
	// 구매내역 나열
	@Override
	public List<BuyBillDTO> buy_list(int start_b, int end_b, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("start_b",start_b);
		map.put("end_b",end_b);
		return sqlSession.selectList("deal.buy_list",map);
	}
	
	@Override
	public List<SellBillDTO> sell_list(int start_s, int end_s, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("start_s",start_s);
		map.put("end_s",end_s);
		return sqlSession.selectList("deal.sell_list",map);
	}

	// 구매내역 갯수
	@Override
	public int buy_count(String search_option, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("deal.buy_count",map);
	}

	@Override
	public BuyBillDTO buy_detail(String b_code) {
		return sqlSession.selectOne("deal.buy_detail", b_code);
	}
	
	@Override
	public BuyBillDTO product_inform(String b_code) {
		return sqlSession.selectOne("deal.buy_infrom", b_code);
	}
	
	@Override
	public void buy_update(BuyBillDTO dto) {
		sqlSession.update("deal.buy_update", dto);
	}
	
	@Override
	public void sell_update(SellBillDTO dto) {
		sqlSession.update("deal.sell_update", dto);
	}

	
	@Override
	public int sell_count(String search_option, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("deal.sell_count",map);
	}

	@Override
	public SellBillDTO sell_detail(String s_code) {
		return sqlSession.selectOne("deal.sell_detail", s_code);
	}

	
	
	// 유저 영역
	
	@Override
	public List<BuyBillDTO> user_buy_deal(String user_id) {
		return sqlSession.selectList("deal.user_buy_deal",user_id);
	}
	
	@Override
	public List<SellBillDTO> user_sell_deal(String user_id) {
		return sqlSession.selectList("deal.user_sell_deal",user_id);
	}
	
	// 구매내역 나열
	@Override
	public List<BuyBillDTO> user_buy_list(int start_b, int end_b, String search_option, String keyword, String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("start_b",start_b);
		map.put("end_b",end_b);
		map.put("user_id", user_id);
		return sqlSession.selectList("deal.user_buy_list",map);
	}
	
	@Override
	public List<SellBillDTO> user_sell_list(int start_s, int end_s, String search_option, String keyword, String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("start_s",start_s);
		map.put("end_s",end_s);
		return sqlSession.selectList("deal.user_sell_list",map);
	}

	// 구매내역 갯수
	@Override
	public int user_buy_count(String search_option, String keyword, String user_id) {
		Map<String,Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("user_id", user_id);
		return sqlSession.selectOne("deal.user_buy_count",map);
	}

	@Override
	public BuyBillDTO user_buy_detail(String b_code, String user_id) {
		Map<String,Object> map = new HashMap<>();
		map.put("b_code", b_code);
		map.put("user_id", user_id);
		return sqlSession.selectOne("deal.user_buy_detail", map);
	}

	
	@Override
	public int user_sell_count(String search_option, String keyword, String user_id) {
		Map<String,Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("user_id", user_id);
		return sqlSession.selectOne("deal.user_sell_count",map);
	}

	@Override
	public SellBillDTO user_sell_detail(String s_code, String user_id) {
		Map<String,Object> map = new HashMap<>();
		map.put("s_code", s_code);
		map.put("user_id", user_id);
		return sqlSession.selectOne("deal.user_sell_detail", map);
	}
}
