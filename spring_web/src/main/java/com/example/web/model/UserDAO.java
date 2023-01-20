package com.example.web.model;

import java.util.List;

public interface UserDAO {

	void insert(UserDTO dto);

	UserDTO detail(String user_id);

	void delete(String user_id);

	void update(UserDTO dto);

	boolean check_passwd(String user_id, String user_passwd);

	String login(UserDTO dto);

	String findid(UserDTO dto);

	String findpasswd(UserDTO dto);

	int check(UserDTO dto); // user.list user_check

	public int idcheck(String user_id);
	
	public List<String> search_search(String str);

	public void user_update(UserDTO dto);
	
	public void user_withdraw(String user_id);
}
