package com.example.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.AdminDAO;
import com.example.web.model.BoardDAO;
import com.example.web.model.PageUtil;
import com.example.web.model.ProductDAO;
import com.example.web.model.ProductDTO;
import com.example.web.model.ReplyDAO;
import com.example.web.model.UserDTO;

@Controller
public class AdminController {
	@Autowired
	ProductDAO productDao;

	@Autowired
	AdminDAO adminDao;
	
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	ReplyDAO replyDao;

	@RequestMapping("admin_saleAll.do")
	@ResponseBody
	public String saleAll(HttpServletRequest request) throws Exception {
		// HttpServletRequest ->회원 정보를 컨트롤러로 보냈을 때 HttpServletRequest 객체 안에 모든 데이터들이 담김
		// 원하는 데이터를 꺼낼때는 HttpServletRequest의 객체 안의 메소드인 getParameter()를 이용
		// getParameter 는 string, getParameterValues는 string[]

		String[] ArrP_code = request.getParameterValues("ArrP_code");
		String[] ArrP_price = request.getParameterValues("ArrP_price");
		double percent = Integer.parseInt((String) request.getParameter("percent")) * 0.01;
		int size = ArrP_code.length;

		for (int i = 0; i < size; i++) {
			System.out.println("product_price : " + ArrP_price[0]);
			int product_price = Integer.parseInt(((String) ArrP_price[i]).replace(",", ""));
			double product_saleprice = product_price * (1 - percent);
			String product_code = ArrP_code[i];
			adminDao.sale_percent(product_code, product_price, product_saleprice);

		}
		if (percent == 0) {
			return "1";
		}
		if (percent == 0.05) {
			return "2";
		} else if (percent == 0.1) {
			return "3";
		} else {
			return "4";
		}

	}

	@RequestMapping("admin_sale.do")
	@ResponseBody
	public String sale(@RequestParam Map<String, Object> map) throws Exception {
		String product_code = (String) map.get("product_code");
		int product_price = Integer.parseInt((String) map.get("product_price"));

		/*
		 * String a = (String)map.get("percent"); int b = a.indexOf("%"); String c =
		 * a.substring(1,b); System.out.println("controllere percnet"+c); double percent
		 * = Integer.parseInt(c)*0.01;
		 */

		double percent = Integer.parseInt((String) map.get("percent")) * 0.01;
		double product_checksale = Integer.parseInt((String) map.get("product_saleprice"));
		double product_saleprice = product_price * (1 - percent);
		System.out.println(percent);
		// -> 배열형 -> string -> int로
		if (product_checksale == product_saleprice) {
			return "0";
		} else if (percent == 0) {
			adminDao.sale_percent(product_code, product_price, product_saleprice);
			return "1";
		} else if (percent == 0.05) {
			adminDao.sale_percent(product_code, product_price, product_saleprice);
			return "2";
		} else if (percent == 0.1) {
			adminDao.sale_percent(product_code, product_price, product_saleprice);
			return "3";
		} else {
			adminDao.sale_percent(product_code, product_price, product_saleprice);
			return "4";
		}

	}

	@RequestMapping("admin_sale_list.do")
	public ModelAndView saleList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {

		int count = adminDao.product_count(search_option, keyword); // 레코드수 개수, xml에서 int값으로 받음

		PageUtil page_info = new PageUtil(count, curPage);
		// 페이지 나누기 처리
		int start = page_info.getPageBegin(); // 레코드 시작 번호
		int end = page_info.getPageEnd();// 레코드 끝번호

		List<ProductDTO> list = adminDao.product_list(start, end, search_option, keyword);// 상품리스트
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/admin_sale");// admin 폴더의 sale페이지
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map", map);
		return mav;
	}

	// 회원정보 리스트
	@RequestMapping("admin_user_list.do") // url과 함수 매핑 => http://localhost/
	public ModelAndView userList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {
		// System.out.println("curPage:"+curPage);

		int count = adminDao.user_count(search_option, keyword); // 레코드수 개수, xml에서 int값으로 받음

		PageUtil page_info = new PageUtil(count, curPage);
		// 페이지 나누기 처리
		int start = page_info.getPageBegin(); // 레코드 시작 번호
		int end = page_info.getPageEnd();// 레코드 끝번호

		List<UserDTO> list = adminDao.user_list(start, end, search_option, keyword);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/admin_list");// admin 폴더의 list페이지
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map", map);
		return mav;
	}

	// 회원정보 복구
	@RequestMapping("admin_restore.do")
	@ResponseBody
	public String restore(HttpServletRequest request) throws Exception {
		// HttpServletRequest ->회원 정보를 컨트롤러로 보냈을 때 HttpServletRequest 객체 안에 모든 데이터들이
		// 들어가게 됩니다!
		// 원하는 데이터를 꺼낼때는 HttpServletRequest의 객체 안의 메소드인 getParameter()를 이용하면
		// 됩니다.(getParameter의 반환타입은 String입니다.)
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for (int i = 0; i < size; i++) {
			adminDao.restore_user(ajaxMsg[i]);
		}
		return "1";

	}

	// 회원정보 탈퇴
	@RequestMapping("admin_drop.do")
	@ResponseBody
	public String drop(HttpServletRequest request) throws Exception {
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for (int i = 0; i < size; i++) {
			adminDao.drop_user(ajaxMsg[i]);
		}
		return "1";
	}

	@RequestMapping("soldout.do")
	public ModelAndView soldout(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {
		// System.out.println("curPage:"+curPage);

		int count = adminDao.soldout_count(search_option, keyword); // 레코드수 개수, xml에서 int값으로 받음

		PageUtil page_info = new PageUtil(count, curPage);
		// 페이지 나누기 처리
		int start = page_info.getPageBegin(); // 레코드 시작 번호
		int end = page_info.getPageEnd();// 레코드 끝번호

		List<ProductDTO> list = adminDao.soldout(start, end, search_option, keyword);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/admin_soldout");// admin 폴더의 list페이지
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map", map);
		return mav;
	}

	@Transactional
	@RequestMapping("admin_board_del.do")
	public String chkbox_del(@RequestParam(value = "chkbox", required = false) List<Integer> chkbox) {

		if (chkbox != null) {
			for (int idx : chkbox) {

				List<String> file_names = boardDao.file_detail(idx);
				boardDao.delete_attach_idx(idx);
				replyDao.delete(idx);

				if (file_names != null) {
					for (String file_name : file_names) {
						new File(file_name.replace("/", File.separator)).delete();
					}
				}
				boardDao.delete(idx);
			}

		}
		return "redirect:/board/list.do";
	}
}
