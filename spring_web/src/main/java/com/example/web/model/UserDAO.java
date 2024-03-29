package com.example.web.model;

import java.util.List;

public interface UserDAO {

	void insert(UserDTO dto);

	UserDTO detail(String user_id);	

	void update(UserDTO dto);
	
	String findId(UserDTO dto);
	
	int findPasswd(UserDTO dto);
	
	void changePasswd(String user_id,String user_passwd);

	boolean login(String user_id, String user_passwd);
	
	int idCheck(String user_id);
	
	int emailCheck(String user_email);
	
	int phoneCheck(String user_phone);
	
	void userWithdraw(String user_id);

	public List<ProductDTO> search_search(String str);

	
	public int emailchk(String user_email);
}
