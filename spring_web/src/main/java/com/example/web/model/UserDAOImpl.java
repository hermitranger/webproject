package com.example.web.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public void insert(UserDTO dto) {
		sqlSession.insert("user.insert", dto);

	}

	@Override
	public UserDTO detail(String user_id) {
		return sqlSession.selectOne("user.detail", user_id);
	}

	@Override
	public void delete(String user_id) {
		sqlSession.delete("member.delete", user_id);

	}
	
	@Override
	public void user_update(UserDTO dto) {
		
		sqlSession.update("user.update",dto);
	}


	@Override
	public void update(UserDTO dto) {
		sqlSession.update("member.update", dto);

	}

	@Override
	public boolean check_passwd(String user_id, String user_passwd) {
		boolean result = false;
		Map<String, String> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("user_passwd", user_passwd);
		int count = sqlSession.selectOne("user.check_passwd", map);
		if (count == 1)
			result = true;
		return result;
	}

	@Override
	public String login(UserDTO dto) {
		return sqlSession.selectOne("user.login", dto);
	}

	@Override
	public String findid(UserDTO dto) {
		return sqlSession.selectOne("user.findid", dto);

	}

	@Override
	public String findpasswd(UserDTO dto) {
		return sqlSession.selectOne("user.findpasswd", dto);

	}

	@Override
	public int check(UserDTO dto) {
		return sqlSession.selectOne("user.check", dto);
	}

	public int idcheck(String user_id) {

		int result = sqlSession.selectOne("user.idcheck", user_id);

		return result;
	}
	
	public List<String> search_search(String str) {
		
		System.out.println("daostr:"+str);
		List<String> list=sqlSession.selectList("search.search",str);
		System.out.println("daolist:"+list);
		return list;
	}
	
	public void user_withdraw(String user_id) {
		System.out.println(user_id);
		sqlSession.update("user.withdraw",user_id);
		
		
	}

}
