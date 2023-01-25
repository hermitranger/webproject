package com.example.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BillDAO;
import com.example.web.model.BuyBillDTO;
import com.example.web.model.PageUtil;
import com.example.web.model.ProductDAO;
import com.example.web.model.ProductDTO;
import com.example.web.model.UserDAO;
import com.example.web.model.UserDTO;

@Controller
public class ProductController {
	@Autowired
	ProductDAO productDao;

	@Autowired
	UserDAO userDao;
	
	@Autowired
	BillDAO billDao;

	@RequestMapping("/shop/write/{b_code}")
	public ModelAndView write(@PathVariable("b_code") String b_code, ModelAndView mav) {
		mav.setViewName("shop/write");
		BuyBillDTO buydetail = billDao.product_inform(b_code);
		mav.addObject("dto", buydetail);
		return mav;
	}

	@RequestMapping("/shop/insert.do")
	public String insert(ProductDTO dto, HttpServletRequest request) {
		String filename = "-";
		if (!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/images/");
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		dto.setFilename(filename);
		productDao.insert(dto);
		return "redirect:/shop/list.do";
	}

	@RequestMapping("/shop/list.do")
	public ModelAndView buyList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/shop/list");
		System.out.println("keyword : " + keyword );
		if(search_option.equals("product_check")) {
			if(keyword.equals("상")) {
				keyword = "2";
				Integer.parseInt(keyword);
			} else if (keyword.equals("중")) {
				keyword = "1";
				Integer.parseInt(keyword);
			} else if (keyword.equals("하")){
				keyword = "0";
				Integer.parseInt(keyword);
			} 
		}
		
		int count = productDao.count(search_option, keyword);

		PageUtil page_info = new PageUtil(count, curPage);

		int start = page_info.getPageBegin();
		int end = page_info.getPageEnd();
		
		List<ProductDTO> list = productDao.list(start, end, search_option, keyword);
		/*
		 * Set<ProductDTO> set = new HashSet<ProductDTO>(list); List<ProductDTO>
		 * new_list = new ArrayList<ProductDTO>(set);
		 */
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map", map);
		return mav;
	}
	
	@RequestMapping("/shop/catelist.do")
	public ModelAndView catelist(@RequestParam(defaultValue ="1") int curPage,			
			@RequestParam(defaultValue="0") int condition,
			@RequestParam(defaultValue = "all") String search_option, 
			@RequestParam(defaultValue="") String keyword)
		 {
		
		ModelAndView mav= new ModelAndView();
		mav.setViewName("/shop/list");
		String find;		
		
		switch (condition) {
		
		case 1 : find="CONVERT(product_code,UNSIGNED) < 200000 "; 
				break;
		case 2 : find="CONVERT(product_code,UNSIGNED) >= 300000 and CONVERT(product_code,UNSIGNED) < 400000";
				break;
		case 3 : find="CONVERT(product_code,UNSIGNED) >= 400000 and CONVERT(product_code,UNSIGNED) < 500000";
				break;
		case 4 : find="CONVERT(product_code,UNSIGNED) >= 600000";
				break;
		default: find="CONVERT(product_code,UNSIGNED) >= 0";
				break;
		//convert(int 형으로 변환시킬 column, int형-unsigned,signed 양수,음수) 비교연산자(>,<,=) 찾을 값(product_code)
				
		}
			
		
		
		int count = productDao.catecount(find);
		
		PageUtil page_info = new PageUtil(count, curPage);

		int start = page_info.getPageBegin();
		int end = page_info.getPageEnd();
		
		List<ProductDTO> list = productDao.catelist(start, end, find);
//		Set<ProductDTO> set = new HashSet<ProductDTO>(list);
//		List<ProductDTO> new_list = new ArrayList<ProductDTO>(set);
//		System.out.println("boardcontroller list:"+list);
//		System.out.println("boardcontroller set:"+set);
//		System.out.println("boardcontroller new_list:"+new_list);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map", map);
		return mav;
	
		
		
	}
	
	@RequestMapping("/shop/edit/{product_code}")
	public ModelAndView edit(@PathVariable("product_code") String product_code, ModelAndView mav) {
		mav.setViewName("/shop/edit");
		mav.addObject("dto", productDao.detail(product_code));
		return mav;
	}

	// 수정 요함
	@RequestMapping("/shop/detail/{product_code}")
	public ModelAndView detail(@PathVariable("product_code") String product_code, ModelAndView mav) {
		mav.setViewName("/shop/detail");
		mav.addObject("dto", productDao.detail(product_code));
		return mav;
	}

	@RequestMapping("/shop/update.do")
	public String update(ProductDTO dto, HttpServletRequest request) {
		String filename = "-";

		if (dto.getFile1() != null && !dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/images/");
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
			dto.setFilename(filename);

		} else {
			ProductDTO dto2 = productDao.detail(dto.getProduct_code());
			dto.setFilename(dto2.getFilename());
		}
		productDao.update(dto);
		return "redirect:/shop/list.do";
	}

	@RequestMapping("/shop/delete.do")
	public String delete(String product_code, HttpServletRequest request) {
		String filename = productDao.file_info(product_code);
		if (filename != null && !filename.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/resources/images/");
			File f = new File(path + filename);
			if (f.exists())
				f.delete();
		}
		productDao.delete(product_code);
		return "redirect:/shop/list.do";
	}
 
	@RequestMapping("/shop/rcheck.do") //추천 중복 확인
	public String recommend_check(HttpSession session, Model model, String product_code) {
		String user_id = (String) session.getAttribute("user_id");
		int count = productDao.recommend_check(product_code, user_id);
		System.out.println(count);
		System.out.printf(product_code+user_id);
		if (count == 0) {
			productDao.recommend_insert(product_code,user_id);
			System.out.println("insert구문"+user_id);
			model.addAttribute("message", "관심등록하였습니다");
		} else {
			productDao.recommend_delete(product_code,user_id);
			System.out.println("delete구문"+user_id);
			model.addAttribute("message", "관심등록해제하였습니다");
		}
		return "/shop/list";
	}

}
