package com.example.web.model;

import java.util.List;

public interface BillDAO {
	List<BuyBillDTO> buy_deal();
	// 통합 페이지용 구매내역
	List<SellBillDTO> sell_deal();
	// 통합 페이지용 판매내역
	
	List<BuyBillDTO> buy_list(int start_b, int end_b, String search_option, String keyword); 
	// 구매내역 나열 + 페이지 분할
	int buy_count(String search_option, String keyword);
	// 구매내역 페이지 분할
	BuyBillDTO buy_detail(String b_code);
	// 구매내역 상세정보
	void buy_update(BuyBillDTO dto);
	// 검수단계, 거래 진행상황 업데이트
	void sell_update(SellBillDTO dto);
	// 거래 진행상황 업데이트

	List<SellBillDTO> sell_list(int start_s, int end_s, String search_option, String keyword); 
	// 판매내역 나열 + 페이지 분할
	int sell_count(String search_option, String keyword);
	// 판매내역 페이지 분할
	SellBillDTO sell_detail(String s_code);
	// 판매내역 상세정보
	
	List<BuyBillDTO> user_buy_deal(String user_id);
	List<SellBillDTO> user_sell_deal(String user_id);
	List<BuyBillDTO> user_buy_list(int start_b, int end_b, String search_option, String keyword, String user_id); 
	// 구매내역 나열 + 페이지 분할
	List<SellBillDTO> user_sell_list(int start_s, int end_s, String search_option, String keyword, String user_id); 
	// 판매내역 나열 + 페이지 분할
	int user_buy_count(String search_option, String keyword, String user_id);
	// 구매내역 페이지 분할
	int user_sell_count(String search_option, String keyword, String user_id);
	// 판매내역 페이지 분할
	BuyBillDTO user_buy_detail(String b_code, String user_id);
	// 구매내역 상세정보
	SellBillDTO user_sell_detail(String s_code, String user_id);
	// 판매내역 상세정보
	BuyBillDTO product_inform(String b_code);
	
	
	int checkRefund(String bill_order1);
	
	void refund_update(String bill_order1);
	
	int checkFinish(String bill_order1);
	
	void refund(String bill_order1);
	
	String refundDo(String bill_order1);
    
    void registration(ProductDTO dto);
    
	int checkCode(String check_code);
	
	void plus(String check_code);
	
	int regischeck(String bill_order);
	
	void billplus(String bill_order);
	
	
	
}
