package com.example.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BillDAO;
import com.example.web.model.BuyBillDTO;
import com.example.web.model.PageUtil;
import com.example.web.model.ProductDAO;
import com.example.web.model.ProductDTO;
import com.example.web.model.UserDAO;

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
	
	@ResponseBody
	@RequestMapping("/shop/insertCheck.do")
	public String insertCheck(@RequestParam String product_model) {
		
		System.out.println(product_model+"	");
		
		int result=productDao.findPModel(product_model);
		//int result1=productDao.findPName(product_name);
		
		System.out.println(result+"   ");
		
		if(result==1) {
			
			//model.addAttribute("error","error");			
			//return "redirect:/shop/list.do";
//			mav.addObject("error", "error");
//			mav.setViewName("redirect:/shop/list.do");
			//responseentity에 mav를 담아서 보내보자!
			
			//return mav;
			return "error";
			//return new ResponseEntity<>(mav,HttpStatus.BAD_REQUEST);
			
		}
		
		return "pass";
		
	}
	
	@ResponseBody
	@RequestMapping("/shop/getProduct_code.do")
	public String getProduct_code(String product_code, HttpSession session) {
		
		long start;
		long end;
		
		start=System.currentTimeMillis();		
		
		
		if(session.getAttribute("end")==null) {
			
			end=0;
		}else {
			end=(long) session.getAttribute("end");
		}
		
		
		if(start-end<1000) {
			
			String result="timelimit";
			
			return result;
						
		}
		
		int test=(Integer.parseInt(product_code)+1000);
		
		String result=findEmptyPcode(product_code, test);
		
		end=System.currentTimeMillis();
		
		session.setAttribute("end", end);
		
		return result;
	}
	
	
	public String findEmptyPcode(String pcode, int test) {
				
		int result=productDao.findPCode(pcode);				
		
		while(result>0) {
			
			int productcode=Integer.parseInt(pcode);
			
			if(productcode < test ) {
				
			pcode = String.valueOf(productcode+10);
			result=productDao.findPCode(pcode);
						
			}else {
				break;
			}
		}
		
		if(Integer.parseInt(pcode)==test) {		
			
			return "error";
		}		
		
	    return pcode;
	
		
	}
	
	
	
	
	

	@RequestMapping("/shop/insert.do")
	public ModelAndView insert(ProductDTO dto, HttpServletRequest request, ModelAndView mav) {
		
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
		}
		dto.setFilename(filename);
				
		dto.setProduct_saleprice(dto.getProduct_price());		
		String pcode=dto.getProduct_code();
		int test=(Integer.parseInt(dto.getProduct_code())+1000);
		
		pcode=findEmptyPcode(pcode,test);
		
		if(Integer.parseInt(pcode)==test) {		
			
			mav.setViewName("redirect:/shop/list.do");
			
			return mav;
		}		
		
		dto.setProduct_code(pcode);		
		productDao.insert(dto);
		mav.setViewName("redirect:/shop/list.do");
		//return "redirect:/shop/list.do";
		return mav;
		//return new ResponseEntity<>(mav,HttpStatus.OK);
	}
	
	
	
	
	
	

	@RequestMapping("/shop/list.do")
	public ModelAndView buyList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String search_option, @RequestParam(defaultValue = "") String keyword) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/shop/list");
		//System.out.println("keyword : " + keyword );
		if(search_option.equals("product_check")) {
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
		
		int count = productDao.count(search_option, keyword);

		PageUtil page_info = new PageUtil(count, curPage);

		int start = page_info.getPageBegin();
		int end = page_info.getPageEnd();
		
		List<ProductDTO> list = productDao.list(start, end, search_option, keyword);
		System.out.println("start"+start+"end"+end+"search_option"+search_option+"keyword"+keyword);
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
	@RequestMapping("/shop/detail/{product_code}") //수정완료0127
	public ModelAndView detail(@PathVariable("product_code") String product_code, ModelAndView mav) {
		mav.setViewName("/shop/detail");
		mav.addObject("dto", productDao.detail(product_code));
		String p_code=product_code.substring(0,6);
		//System.out.println("p_code:"+p_code);
		mav.addObject("list", productDao.recommendList(p_code,product_code));//추천목록추가0127
		return mav;
	}

	@RequestMapping("/shop/detailBuy/{product_code}") //추가 0213 buy유저가 구매하는걸로 햇음. 
	public ModelAndView detailBuy(@PathVariable("product_code") String product_code, ModelAndView mav) {
		mav.setViewName("/shop/detailBuy");
		mav.addObject("dto", productDao.detail(product_code));
		//System.out.println("product_code" + product_code);
		String p_code=product_code.substring(0,6);
		//System.out.println("p_code:"+p_code);
		mav.addObject("list", productDao.recommendList(p_code,product_code));//추천목록추가0127 ???
		String top_price=(String)product_code.substring(0, 8)+"3";
		//System.out.println("top_price" + top_price);
		String mid_price=(String)product_code.substring(0, 8)+"2";
		String bot_price=(String)product_code.substring(0, 8)+"1";
		mav.addObject("dto1",productDao.eachPrice(bot_price));
		mav.addObject("dto2",productDao.eachPrice(mid_price));
		mav.addObject("dto3",productDao.eachPrice(top_price));

		
		//System.out.println("productDao.eachPrice(bot_price) : "+ productDao.eachPrice(bot_price));
		//System.out.println("productDao.eachPrice(mid_price) : "+ productDao.eachPrice(mid_price));
		//System.out.println("productDao.eachPrice(top_price) : "+ productDao.eachPrice(top_price));
		
		return mav;
	}

	
	@RequestMapping("/shop/detailSell/{product_code}")  //추가 0213 sell유저가 판매하는걸로 햇음. 
	public ModelAndView detailSell(@PathVariable("product_code") String product_code, ModelAndView mav) {
		mav.setViewName("/shop/detailSell");
		mav.addObject("dto", productDao.detail(product_code));
		String p_code=product_code.substring(0,6);
		System.out.println("p_code:"+p_code);
		mav.addObject("list", productDao.recommendList(p_code,product_code));//추천목록추가0127
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
	
	@RequestMapping("/shop/search.do")
	public @ResponseBody String search_search(String keyword){
		
		System.out.println(keyword);
		if(keyword.equals("")) {
			return "";
		}
		
		String str="%"+keyword+"%";
		System.out.println(str);
		List<ProductDTO> list= userDao.search_search(str);
		System.out.println(list);
		String html="";
		ProductDTO dto = new ProductDTO();
		
		for(int i=0; i<list.size();i++) {
			
			dto=list.get(i);
			
			html+="<a href='/shop/detail/"+dto.getProduct_code()+"' style='color:black'>"+dto.getProduct_name()+"</a><br>";			
			
		}
		
		System.out.println(list);
		
		return html;		
	}
	
	
	
	

}
