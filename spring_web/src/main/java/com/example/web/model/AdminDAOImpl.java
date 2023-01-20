package com.example.web.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAOImpl implements AdminDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<ProductDTO> product_list(int start, int end, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("admin.product_list", map);

	}

	@Override
	public List<ProductDTO> soldout(int start, int end, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("admin.soldout", map);
	}

	@Override
	public List<UserDTO> user_list(int start, int end, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("admin.user_list", map);// 12/23 수정 user-> admin
	}

	@Override
	public List<UserDTO> restore_user(String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("user_id", user_id);
		return sqlSession.selectList("admin.restore", map);// 12/23 수정 user-> admin
	}

	@Override
	public List<UserDTO> drop_user(String user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("user_id", user_id);
		return sqlSession.selectList("admin.drop", map);// 12/23 수정 user-> admin

	}

	@Override
	public int user_count(String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		//dto=dad.setdsajflka()
		//dto=dad.setdaklfj() ,dto) //dto에서 선언한거랑 변수명이 같아야한다.
		return sqlSession.selectOne("admin.user_count", map);// 12/23 수정 user-> admin

	}

	@Override
	public int product_count(String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("admin.product_count", map);// 12/23 수정 user-> admin

	}
	
	@Override
	public int soldout_count(String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("admin.soldout_count", map);// 12/23 수정 user-> admin

	}

	/*
	 * @Override public int count(String search_option, String keyword) {
	 * Map<String,Object> map = new HashMap<>(); map.put("search_option",
	 * search_option); map.put("keyword", keyword); return
	 * sqlSession.selectOne("user.count",map); }
	 */

	
	@Override
	public List<ProductDTO> sale_percent(String product_code, double product_price, double product_saleprice) {
		Map<String, Object> map = new HashMap<>();
		map.put("product_code", product_code);
		map.put("product_price", product_price);
		map.put("product_saleprice", product_saleprice);
		System.out.println("daoimpl_product_code" + product_code);

		return sqlSession.selectList("admin.sale_percent", map);// 12/23 수정 user-> admin

	}
}
