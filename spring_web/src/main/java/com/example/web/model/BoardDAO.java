package com.example.web.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<BoardDTO> list(int start, int end, String search_option, String keyword){
		
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("start", start-1);
		map.put("end", end);
		
		List<BoardDTO> list= sqlSession.selectList("board.list", map);
		
		
		return list;
	}
	
	public void insert(BoardDTO dto) {
		sqlSession.insert("board.insert",dto);
	}
	
	public BoardDTO detail(int idx) {
		return sqlSession.selectOne("board.detail",idx);
	}
	
	public void increase_hit(int idx) {
		sqlSession.update("board.increase_hit",idx);
	}
	
	
	public void update(BoardDTO dto) {
		sqlSession.update("board.update", dto);
	}
	
	
	public void delete(int idx) {
		sqlSession.delete("board.delete", idx);
	}
	
	public int count(String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("board.count",map);
	}
	
	public List<String> list_attach(int idx){
		return sqlSession.selectList("board.list_attach",idx);
		
	}
	
	
	public void insert_attach(String file_name) {
		sqlSession.insert("board.insert_attach", file_name);
	}
	
	public void update_attach(String file_name, int idx) {
		Map<String, Object> map = new HashMap<>();		
		map.put("file_name", file_name);
		map.put("idx", idx);
		sqlSession.insert("board.update_attach",map);
	}
	
	public void delete_attach(String file_name) {
		sqlSession.delete("board.delete_attach", file_name);
	}
	
	public int idx() {
		int idx=sqlSession.selectOne("board.idx");
		return idx;
	}
	
	public void delete_attach_idx(int idx) {
		sqlSession.delete("board.delete_attach_idx",idx);
	}
	
	public List<String> file_detail(int idx) {
		
		List<String> list= sqlSession.selectList("board.file_detail",idx);
		
		return list;
	}

}
