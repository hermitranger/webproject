package com.example.web.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> new_list() {
		return sqlSession.selectList("product.new_list");
	}

	@Override
	public List<ProductDTO> list(int start, int end, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("start",start-1);
		map.put("end",end);
		return sqlSession.selectList("product.list",map);
	}


	@Override
	public int count(String search_option, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("product.count",map);
	}

	@Override
	public ProductDTO detail(String product_code) {
		return sqlSession.selectOne("product.detail", product_code);
	}

	@Override
	public void update(ProductDTO dto) {
		sqlSession.update("product.update", dto);
	}

	@Override
	public void delete(String product_code) {
		sqlSession.delete("product.delete", product_code);
	}

	@Override
	public void insert(ProductDTO dto) {
		sqlSession.insert("product.insert", dto);
	}

	@Override
	public String file_info(String product_code) {
		return sqlSession.selectOne("product.file_info", product_code);
	}

	@Override
	public int recommend_check(String product_code, String user_id) {
		Map<String,Object> map=new HashMap<>();
		map.put("product_code", product_code);
		map.put("user_id",user_id);
		return sqlSession.selectOne("product.recommend_check",map);
	}

	@Override
	public void recommend_insert(String product_code,String user_id) {
		Map<String,Object> map=new HashMap<>();
		map.put("product_code", product_code);
		map.put("user_id",user_id);
		 sqlSession.selectOne("product.recommend_insert",map);
	}
	
	@Override
	public void recommend_delete(String product_code,String user_id) {
		Map<String,Object> map=new HashMap<>();
		map.put("product_code", product_code);
		map.put("user_id",user_id);
		sqlSession.selectOne("product.recommend_delete", map);
	}
	
	@Override
	public List<ProductDTO> catelist(int start, int end, String find){
		
		Map<String,Object> map = new HashMap<>();
		map.put("find", find);
		
		map.put("start",start-1);
		map.put("end", end);
		//System.out.println("start:end="+start+":"+end);		
		return sqlSession.selectList("product.catelist",map);
		
	}
	
	@Override
	public List<ProductDTO> recommendList(String p_code,String product_code){//추천목록0127
		
		Map<String,String> map = new HashMap<>();
		map.put("p_code", p_code);
		map.put("product_code", product_code);
		
		return sqlSession.selectList("product.recommendList",map);
		
	}
	
	
	
	@Override
	public int catecount(String find){
		
		Map<String,Object> map = new HashMap<>();
		map.put("find", find);
		
				
		return sqlSession.selectOne("product.catecount",map);
		
	}
	
	@Override
	public int findPModel(String pmodel) {
		
		return sqlSession.selectOne("product.findpmodel",pmodel);
	}
	
	@Override
	public int findPCode(String pcode) {

		return sqlSession.selectOne("product.findpcode",pcode);
	}
	
	@Override
	   public ProductDTO eachPrice(String product_code) {   
	      return sqlSession.selectOne("product.eachprice",product_code);      
	   }
	
//	@Override
//	public int findPName(String pname) {
//		
//		return sqlSession.selectOne("product.findpname",pname);
//	}
}