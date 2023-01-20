package com.example.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BillDAO;
import com.example.web.model.BuyBillDTO;
import com.example.web.model.PageUtil;
import com.example.web.model.SellBillDTO;

@Controller
public class BillController {

	@Autowired
	BillDAO billDao;
	
	// 운영자 
	@RequestMapping("admin_deal.do")
	public ModelAndView deallist(ModelAndView mav) {
		mav.setViewName("admin/admin_deal");
		List<BuyBillDTO> buylist = billDao.buy_deal();
		List<SellBillDTO> selllist = billDao.sell_deal();
		mav.addObject("buylist", buylist);
		mav.addObject("selllist", selllist);
		return mav;
	}

	@RequestMapping("/admin/admin_deal_buylist.do")
	public ModelAndView buyList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin/admin_deal_buylist");
		
		if(search_option.equals("b_check")) {
			if(keyword.equals("상")) {
				keyword = "0";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "1";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "2";
				Integer.parseInt(keyword);
			} 
		}
		
		// 구매내역
		int count_b = billDao.buy_count(search_option, keyword);

		PageUtil page_info_b = new PageUtil(count_b, curPage);

		int start_b = page_info_b.getPageBegin();
		int end_b = page_info_b.getPageEnd();
		
		List<BuyBillDTO> buylist = billDao.buy_list(start_b, end_b, search_option, keyword);

		Map<String, Object> buymap = new HashMap<>();
		buymap.put("list", buylist);
		buymap.put("count", count_b);
		buymap.put("search_option", search_option);
		buymap.put("keyword", keyword);
		buymap.put("page_info_b", page_info_b);
		mav.addObject("buymap", buymap);
		return mav;
	}

	@RequestMapping("/admin/admin_deal_selllist.do")
	public ModelAndView sellList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {
		ModelAndView mav = new ModelAndView();

		if(search_option.equals("s_check")) {
			if(keyword.equals("상")) {
				keyword = "0";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "1";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "2";
				Integer.parseInt(keyword);
			} 
		}


		// 판매내역
		int count_s = billDao.sell_count(search_option, keyword);
		PageUtil page_info_s = new PageUtil(count_s, curPage);
		int start_s = page_info_s.getPageBegin();
		int end_s = page_info_s.getPageEnd();
		
		List<SellBillDTO> selllist = billDao.sell_list(start_s, end_s, search_option, keyword);
		mav.setViewName("/admin/admin_deal_selllist");
		Map<String, Object> sellmap = new HashMap<>();
		sellmap.put("list", selllist);
		sellmap.put("count", count_s);
		sellmap.put("search_option", search_option);
		sellmap.put("keyword", keyword);
		sellmap.put("page_info_s", page_info_s);
		mav.addObject("sellmap", sellmap);

		return mav;
	}
	// 거래내역 상세

	@RequestMapping("/admin/admin_deal_buydetail/{b_code}")
	public ModelAndView buy_detail(@PathVariable("b_code") String b_code, ModelAndView mav) {
		mav.setViewName("admin/admin_deal_buydetail");
		BuyBillDTO buydetail = billDao.buy_detail(b_code);
		mav.addObject("dto", buydetail);
		return mav;
	}
	
	@RequestMapping("/admin/buy_update.do")
	public String update(BuyBillDTO dto) {
		billDao.buy_update(dto);
		return "redirect:admin_deal_buylist.do";
	}

	@RequestMapping("/admin/admin_deal_selldetail/{s_code}")
	public ModelAndView sell_detail(@PathVariable("s_code") String s_code, ModelAndView mav) {
		mav.setViewName("admin/admin_deal_selldetail");
		SellBillDTO selldetail = billDao.sell_detail(s_code);
		mav.addObject("dto", selldetail);
		return mav;
	}

	
	// 유저관련
	@RequestMapping("user_deal.do")
	public ModelAndView user_deallist(ModelAndView mav, HttpSession session) {
		mav.setViewName("/user/user_deal");
		String user_id=(String)session.getAttribute("user_id");
		List<BuyBillDTO> buylist = billDao.user_buy_deal(user_id);
		List<SellBillDTO> selllist = billDao.user_sell_deal(user_id);
		mav.addObject("buylist", buylist);
		mav.addObject("selllist", selllist);
		return mav;
	}

	@RequestMapping("user/user_deal_buylist.do")
	public ModelAndView user_buyList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/user_deal_buylist");
		String user_id=(String)session.getAttribute("user_id");
		if(search_option.equals("b_check")) {
			if(keyword.equals("상")) {
				keyword = "0";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "1";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "2";
				Integer.parseInt(keyword);
			} 
		}
		
		// 구매내역
		int count_b = billDao.user_buy_count(search_option, keyword, user_id);

		PageUtil page_info_b = new PageUtil(count_b, curPage);

		int start_b = page_info_b.getPageBegin();
		int end_b = page_info_b.getPageEnd();
		
		List<BuyBillDTO> buylist = billDao.user_buy_list(start_b, end_b, search_option, keyword, user_id);

		Map<String, Object> buymap = new HashMap<>();
		buymap.put("list", buylist);
		buymap.put("count", count_b);
		buymap.put("search_option", search_option);
		buymap.put("keyword", keyword);
		buymap.put("page_info_b", page_info_b);
		mav.addObject("buymap", buymap);
		return mav;
	}

	@RequestMapping("user/user_deal_selllist.do")
	public ModelAndView user_sellList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String user_id=(String)session.getAttribute("user_id");
		
		if(search_option.equals("s_check")) {
			if(keyword.equals("상")) {
				keyword = "0";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "1";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "2";
				Integer.parseInt(keyword);
			} 
		}


		// 판매내역
		int count_s = billDao.user_sell_count(search_option, keyword, user_id);
		PageUtil page_info_s = new PageUtil(count_s, curPage);
		int start_s = page_info_s.getPageBegin();
		int end_s = page_info_s.getPageEnd();
		
		List<SellBillDTO> selllist = billDao.user_sell_list(start_s, end_s, search_option, keyword, user_id);
		mav.setViewName("user/user_deal_selllist");
		Map<String, Object> sellmap = new HashMap<>();
		sellmap.put("list", selllist);
		sellmap.put("count", count_s);
		sellmap.put("search_option", search_option);
		sellmap.put("keyword", keyword);
		sellmap.put("page_info_s", page_info_s);
		mav.addObject("sellmap", sellmap);

		return mav;
	}
	// 거래내역 상세

	@RequestMapping("user/user_deal_buydetail/{b_code}")
	public ModelAndView user_buy_detail(@PathVariable("b_code") String b_code, ModelAndView mav, HttpSession session) {
		mav.setViewName("user/user_deal_buydetail");
		String user_id=(String)session.getAttribute("user_id");
		BuyBillDTO buydetail = billDao.user_buy_detail(b_code, user_id);
		mav.addObject("dto", buydetail);
		return mav;
	}

	@RequestMapping("user/user_deal_selldetail/{s_code}")
	public ModelAndView user_sell_detail(@PathVariable("s_code") String s_code, ModelAndView mav, HttpSession session) {
		mav.setViewName("user/user_deal_selldetail");
		String user_id=(String)session.getAttribute("user_id");
		SellBillDTO selldetail = billDao.user_sell_detail(s_code, user_id);
		mav.addObject("dto", selldetail);
		return mav;
	}
}
