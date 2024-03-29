package com.example.web.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BillDAO;
import com.example.web.model.BuyBillDTO;
import com.example.web.model.PageUtil;
import com.example.web.model.PaymentService;
import com.example.web.model.ProductDTO;
import com.example.web.model.SellBillDTO;
import com.example.web.model.SellOrderDAO;

@Controller
public class BillController {

	@Autowired
	BillDAO billDao;
	
	@Autowired
	PaymentService paymentService;
	
	@Autowired
	SellOrderDAO SellOrderDao;
	
	// 운영자 
	@RequestMapping("admin_deal.do")
	public ModelAndView deallist(ModelAndView mav) {
		mav.setViewName("admin/admin_deal");
		List<BuyBillDTO> buylist = billDao.buy_deal();
		List<SellBillDTO> selllist = billDao.sell_deal();
		//System.out.println("billcontrolelr admin buylist:  "+buylist );
		//System.out.println("billcontrolelr admin selllist:  "+selllist );
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
				keyword = "3";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "2";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "1";
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
				keyword = "3";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "2";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "1";
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
		//System.out.println("Billcontroller selllist: "+selllist);

		return mav;
	}
	// 거래내역 상세

	@RequestMapping("/admin/admin_deal_buydetail/{b_code}")
	public ModelAndView buy_detail(@PathVariable("b_code") String b_code, ModelAndView mav) {
		mav.setViewName("admin/admin_deal_buydetail");
		BuyBillDTO buydetail = billDao.buy_detail(b_code);
		mav.addObject("dto", buydetail);
		//System.out.println("billcontroller buydetail : " + buydetail);
		return mav;
	}
	
	@RequestMapping("/admin/buy_update.do")
	public String update_B(BuyBillDTO dto) {//관리자 구매목록 - 편집 - 진행상황 및 검수 수정사항 업데이트
		billDao.buy_update(dto);
		return "redirect:admin_deal_buylist.do";
	}
	
	@RequestMapping("/admin/sell_update.do")
	public String update_S(SellBillDTO dto) {//관리자 판매목록 - 편집 - 진행상황 업데이트
		billDao.sell_update(dto);
		return "redirect:admin_deal_selllist.do";
	}

	@RequestMapping("/admin/admin_deal_selldetail/{s_code}")
	public ModelAndView sell_detail(@PathVariable("s_code") String s_code, ModelAndView mav) {
		mav.setViewName("admin/admin_deal_selldetail");
		SellBillDTO selldetail = billDao.sell_detail(s_code);
		mav.addObject("dto", selldetail);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/admin/Registration.do")
	public String registration(@RequestParam String bill_order,@RequestParam String product_code, @RequestParam String check) {//관리자 판매목록 - 편집 - 진행상황 업데이트
		System.out.println(bill_order);
		int billcheck=billDao.regischeck(bill_order);
		System.out.println("billcheck" + billcheck);
		if(billcheck>0) {
		
			ProductDTO dto = SellOrderDao.Sell_Product(product_code);
			String name=dto.getProduct_name();
			String code=dto.getProduct_code();
			int price=dto.getProduct_price();
			int saleprice=dto.getProduct_saleprice();
			
			if(check.equals("하")) {
				System.out.println("하");
				
				String bot_name=name+"("+check+")";
				String check_code=code.substring(0,8)+"1";
				int check1 = billDao.checkCode(check_code);
				if(check1==0)
				{
					dto.setProduct_name(bot_name);
					dto.setProduct_code(check_code);
					dto.setProduct_price(price);
					dto.setProduct_saleprice(saleprice);

					billDao.registration(dto);}
				else {
					billDao.plus(check_code);		
				}
			}
			else if(check.equals("중")) {
				String mid_name=name+"("+check+")";
				String check_code=code.substring(0,8)+"2";
				int check2 = billDao.checkCode(check_code);
				int mid_price = price+(price*5/100);
				int mid_saleprice = saleprice+(saleprice*5/100);
				if(check2==0)
				{
				dto.setProduct_name(mid_name);
				dto.setProduct_name(check_code);
				dto.setProduct_price(mid_price);
				dto.setProduct_saleprice(mid_saleprice);
				billDao.registration(dto);}
				else {
					billDao.plus(check_code);		
				}
				
				
			}else if(check.equals("상")) {
				String top_name=name+"("+check+")";
				String check_code=code.substring(0,8)+"3";
				int top_price = price+(price*5/100);
				int top_saleprice = saleprice+(saleprice*10/100);
				int check3 = billDao.checkCode(check_code);
				if(check3==0)
				{
				dto.setProduct_name(top_name);
				dto.setProduct_name(check_code);
				dto.setProduct_price(top_price);
				dto.setProduct_saleprice(top_saleprice);
				billDao.registration(dto);}
			else {
				billDao.plus(check_code);		
				}
				
			}
			billDao.billplus(bill_order);
			return "1";
		}else {return "2";}
		
	}
	

	
	// 유저관련
	@RequestMapping("user_deal.do")
	public ModelAndView user_deallist(ModelAndView mav, HttpSession session) {
		mav.setViewName("/user/user_deal");
		String user_id=(String)session.getAttribute("user_id");
		List<BuyBillDTO> buylist = billDao.user_buy_deal(user_id);
		List<SellBillDTO> selllist = billDao.user_sell_deal(user_id);
		//System.out.println("billcontrolelr buylist:  "+buylist );
		//System.out.println("billcontrolelr selllist:  "+selllist );
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
				keyword = "3";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "2";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "1";
				Integer.parseInt(keyword);
			}
			else if (keyword.equals("미검수")){
				keyword = "0";
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
				keyword = "3";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "2";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "1";
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
	
	@ResponseBody
	@Transactional
	@RequestMapping("user/plzRefund.do")
	public String plzRefund(@RequestParam String bill_order) {
		String bill_order1 = (String)bill_order;
		int check =billDao.checkRefund(bill_order1);
		if(check>0) {
			return "2";
		}
		else {
			//billDao.plzRefund(bill_order1);
			billDao.refund_update(bill_order1);
			//조인 문 사용 해서 sell_bill에서 값 가져오고
			return "1";
		}
		
	}
	@ResponseBody
	@Transactional
	@RequestMapping("admin/refund.do")
	public String refund(@RequestParam String bill_order) throws IOException{
		String token = paymentService.getToken();
		String bill_order1 = (String)bill_order;
		int check =billDao.checkFinish(bill_order1);
		if(check>0) {
			return "2";
		}
		else {	
			String Imp_uid = billDao.refundDo(bill_order1);
			try {
				paymentService.payMentCancle(token, Imp_uid, "오류");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			billDao.refund(bill_order1);
			//조인 문 사용 해서 sell_bill에서 값 가져오고
			return "1";
		}
		
	}
	
	
	
	
}
