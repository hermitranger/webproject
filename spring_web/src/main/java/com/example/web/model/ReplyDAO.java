package com.example.web.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<ReplyDTO> list(int board_idx, int start, int end){ //댓글 리스트
		Map<String, Object> map= new HashMap<>();
		map.put("start", start-1);		
		map.put("end", end);
		map.put("board_idx", board_idx);
		List<ReplyDTO> items = sqlSession.selectList("reply.list",map);
		return items;
	}
	
	public int count(int board_idx) { //댓글 개수
		return sqlSession.selectOne("reply.count",board_idx);
	}
	
	
	public void update(ReplyDTO dto) { //댓글 수정
		System.out.println("dto:"+dto);
		sqlSession.update("reply.update",dto);
	}
	
	public void delete(int idx) {//댓글 삭제
		sqlSession.delete("reply.delete",idx);
	}
	
	public ReplyDTO detail(int idx) {//댓글 상세
		return sqlSession.selectOne("reply.detail",idx);
	}
	
	
	public void insert(ReplyDTO dto) {
		sqlSession.insert("reply.insert",dto);
	}

}
