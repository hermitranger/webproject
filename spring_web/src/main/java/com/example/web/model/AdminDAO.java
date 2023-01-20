package com.example.web.model;

import java.util.List;

public interface AdminDAO {
	
	List<UserDTO> user_list(int start, int end, String search_option,String keyword);

	List<UserDTO> restore_user(String user_id);//user.list 회원복구
	
	List<UserDTO> drop_user(String user_id);//user.list 회원탈퇴
	
	List<ProductDTO> sale_percent(String product_code, double product_price, double product_saleprice);
	
	int user_count(String search_option, String keyword);////user.list 유저목록 페이지 나누기

	int product_count(String search_option, String keyword);////user.list 유저목록 페이지 나누기
	
	int soldout_count(String search_option, String keyword);
	
	List<ProductDTO> product_list(int start, int end, String search_option, String keyword);
	
	List<ProductDTO> soldout(int start, int end, String search_option, String keyword);
}
