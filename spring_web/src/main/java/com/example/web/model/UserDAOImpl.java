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
	public void update(UserDTO dto) {
		
		sqlSession.update("user.update",dto);
	}


	@Override
	public String findId(UserDTO dto){
		
		Map<String, String> map = new HashMap<>();
		map.put("user_name", dto.getUser_name());
		map.put("user_email", dto.getUser_email());
		String user_id = sqlSession.selectOne("user.findid", map);
		
		return user_id;
	}
	
	@Override
	public int findPasswd(UserDTO dto){
		
		return sqlSession.selectOne("user.findpasswd", dto);

	}
	
	@Override
	public void changePasswd(String user_id, String user_passwd) {
			
		Map<String,String> map=new HashMap<>();
		map.put("user_id", user_id);
		map.put("user_passwd", user_passwd);
		sqlSession.update("user.changepasswd",map);
	}
	
	

	@Override
	public boolean login(String user_id, String user_passwd) {
		
		Map<String,String> map= new HashMap<>();
		map.put("user_id", user_id);
		map.put("user_passwd", user_passwd);
		boolean result= false;
		
		int count = sqlSession.selectOne("user.passwdcheck", map);
		
		if (count == 1) {
			result = true;
			
			return result;
			}
		
		return result;
		
//		null 일때를 대비해서 예외처리
//		Object obj= sqlSession.selectOne("user.login", map);
//		if(obj==null) {
//			return result;
//		}else {
//			
//			return result=1; 
//		}		
		
	}

	@Override
	public int idCheck(String user_id){
		return sqlSession.selectOne("user.idcheck", user_id);
	}

	
	@Override
	public int emailCheck(String user_email) {
		
		return sqlSession.selectOne("user.emailcheck", user_email);
		
	}
	

	@Override
	public int phoneCheck(String user_phone) {
		return sqlSession.selectOne("user.phonecheck", user_phone);
	}
	
	@Override
	public void userWithdraw(String user_id) {
		
		sqlSession.update("user.withdraw",user_id);
				
	}
	
	@Override
	
	public List<String> search_search(String str) {		
		System.out.println("daostr:"+str);
		List<String> list=sqlSession.selectList("search.search",str);
		System.out.println("daolist:"+list);
		return list;
	}

}
