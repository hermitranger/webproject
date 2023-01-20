package com.example.web.model;

import java.util.List;

public interface ProductDAO {
	List<ProductDTO> list(int start, int end, String search_option, String keyword);
	int count(String search_option, String keyword);
	ProductDTO detail(String product_code);
	void update(ProductDTO dto);
	void delete(String product_code);
	void insert(ProductDTO dto);
	String file_info(String product_code);
	public int recommend_check(String product_code,String user_id);
	public void recommend_insert(String product_code, String user_id);
	public void recommend_delete(String product_code,String user_id);
	public List<ProductDTO> new_list();
}
