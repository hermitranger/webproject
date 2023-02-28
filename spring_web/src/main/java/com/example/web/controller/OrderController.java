package com.example.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BuyOrderDAO;
import com.example.web.model.DealDTO;
import com.example.web.model.PaymentService;
import com.example.web.model.ProductDTO;
import com.example.web.model.SellOrderDAO;
import com.example.web.model.UserDTO;

@Controller
public class OrderController {

	@Autowired
	BuyOrderDAO BuyOrderDao;

	@Autowired
	SellOrderDAO SellOrderDao;
	
	@Autowired
	PaymentService paymentService;

	//jsp에서 1~3을 어떻게 넘겨줄까..
	//해당 데이터가 잇는지 확인
	

	@RequestMapping("OrderBuy.do")
	public ModelAndView sale(@RequestParam String product_code, ModelAndView mav, HttpServletRequest request) {
		
		
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("userid" + user_id);
		if (user_id != null) {
			mav.addObject("Pdto", BuyOrderDao.Buy_Product(product_code));
			mav.addObject("Udto", BuyOrderDao.Buy_User(user_id));
			mav.setViewName("/shop/buy");
			return mav;

		} else {
			mav.setViewName("/login/login");
			return mav;

		}

	}

	/*
	 * 무조건 3번 돌려서 not null 이면 add
	 * 
	 * for문돌려서 i 1~3넣고 product1 product2 producr3
	 * 
	 * jsp단에서도 1~3돌리고
	 * 
	 * 장바구니에서 할때는 똑같은거 변수 하나 주고
	 * 
	 * if 이거면 이거 만들고, 아니면 이거 다돌려서 확인하면 되겟구만유.
	 */
	
	@Transactional
	@RequestMapping("OrderSell2.do")                        
	public ModelAndView OrderSell2(@RequestParam String[] ArrP_code,@RequestParam String[] ArrP_price,@RequestParam String[] ArrP_saleprice,
			@RequestParam String[] ArrP_count,@RequestParam String[] ArrP_sumprice,@RequestParam String[] ArrP_name,
			@RequestParam Map<String, String> map2,HttpServletRequest request, ModelAndView mav) {

		HttpSession session = request.getSession();
		String user_id= (String)session.getAttribute("user_id");
		//System.out.println(ArrP_code);
		int length = ArrP_code.length;
		//System.out.println("length : " +length);
		String product_code0= map2.get("product_code");//대표품목 코드번호
		String size = product_code0.substring(5,6);//대표품목 번호에서 사이즈 추가
		
		List<DealDTO> list= new ArrayList<DealDTO>();
		for(int i=0;i<length;i++) {
			DealDTO dto = new DealDTO();
			String product_name = ArrP_name[i];
			String product_code = ArrP_code[i];
			//System.out.println("product_code"+ product_code);
			int product_price = Integer.parseInt(ArrP_price[i]);
			//System.out.println("product_price: "+ product_price);
			int  product_saleprice = Integer.parseInt(ArrP_saleprice[i]);
			//System.out.println("product_saleprice: "+product_saleprice);
			int  count = Integer.parseInt(ArrP_count[i]);
			//System.out.println("count"+ count);
			int  sum_price = Integer.parseInt(ArrP_sumprice[i]);
			//System.out.println("sum_price"+ sum_price);
			double result=(((double)product_price-(double)product_saleprice)/(double)product_price)*100;
			double sale= Math.round(result);
			//System.out.println("sale: "+sale);
			dto.setProduct_name(product_name);
	        dto.setSale(sale);
			dto.setProduct_code(product_code);
			dto.setProduct_price(product_price);
			dto.setProduct_saleprice(product_saleprice);
			dto.setCount(count);
			dto.setSum_price(sum_price);
			list.add(dto);
		}
		//System.out.println(list);


		 if(user_id == null) { 
			 mav.setViewName("/login/login"); 
			 return mav; 	 
		 }
		 else {
			 	Map<String, Object> map = new HashMap<>();
				map.put("list", list);
				map.put("size", size);
				map.put("product_code0", map2.get("product_code"));
				map.put("product_name", map2.get("product_name"));
				map.put("total_price", map2.get("total_price"));
				map.put("total_count", map2.get("total_count"));
				map.put("user_id", user_id);
				mav.addObject("map", map);
			 	mav.setViewName("/shop/sell2");
				return mav; 			 
		 }
			//@RequestParam Map<String, String> map,HttpServletRequest request, ModelAndView mav 
			// boolean iskey1 = map.containsKey("product_code1");
			 // 재고 재확인 하기.
			 // p_num 요청 수량 , product_code, product_price, product_saleprice
			// map에 넘겨준 변수명 
		
			/*
			 * System.out.println(map); boolean iskey1 = map.containsKey("product_code1");
			 * boolean iskey2 = map.containsKey("product_code2"); boolean iskey3 =
			 * map.containsKey("product_code3"); HttpSession session = request.getSession();
			 * String user_id= (String)session.getAttribute("user_id"); if(user_id == null)
			 * { mav.setViewName("/login/login"); return mav; } else { if(iskey1==true)
			 * {map.put("product_name1","하등급");} if(iskey2==true)
			 * {map.put("product_name2","중등급");} if(iskey3==true)
			 * {map.put("product_name3","상등급");} map.put("each", "1"); mav.addObject("p",
			 * map);// 해당 sell에 넘겨줌 mav.addObject("Udto", SellOrderDao.Sell_User(user_id));
			 * //List<DealDTO> list = map;// 상품리스트 //ModelAndView mav = new ModelAndView();
			 * //mav.setViewName("admin/admin_sale");// admin 폴더의 sale페이지 //Map<String,
			 * Object> map = new HashMap<>(); //map.put("list", list);
			 * 
			 * //dto
			 * 
			 * 
			 * 
			 * return mav; }
			 */		 
}
		
	
	@RequestMapping("OrderSell.do")
	public ModelAndView OrderSell(@RequestParam String product_code, ModelAndView mav, HttpServletRequest request) {
		System.out.println("OrderSell product_code"+product_code);
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");

		System.out.println("userid" + user_id);
		if (user_id != null) {
			mav.addObject("Pdto", SellOrderDao.Sell_Product(product_code));
			mav.addObject("Udto", SellOrderDao.Sell_User(user_id));
			mav.setViewName("/shop/sell");
			return mav;

		} else {
			mav.setViewName("/login/login");
			return mav;

		}

	}
	

	@Transactional
	@RequestMapping("BuyResult.do")
	@ResponseBody
	public String BuyResult(@RequestParam Map<String, Object> map) {

		String product_code = (String) map.get("product_code");
		String user_id = (String) map.get("user_id");
		String bill_order = (String) map.get("bill_order");
		String buy_post = (String) map.get("zipcode");
		String buy_address = (String) map.get("address1") + " " + (String) map.get("address2");
		int bill_deliver = Integer.parseInt(map.get("fee").toString());// 오브젝트형 -> 인트 하는법 : 스트링 변환후 parseInt
		ProductDTO Pdto = BuyOrderDao.Buy_Product(product_code);
		UserDTO Udto = BuyOrderDao.Buy_User(user_id);
		BuyOrderDao.Buy_Result(Pdto, Udto, bill_order, buy_address, buy_post, bill_deliver);

		return "1";
		

	}
	
	
	//window.onclose 이벤트 확인해보기
	//transactional crud해도 이벤트가 도중에 동작이 그만두면 완료가 되지 않는다.  확
	   @Transactional
	   @RequestMapping("SellResult.do")
	   @ResponseBody
	   public String SellResult(@RequestParam Map<String, Object> map,HttpSession session) throws IOException{
	      String token = paymentService.getToken();
	      System.out.println("토큰 : " + token);
	      String imp_uid = (String)map.get("imp_uid");
	      String[] ArrP_name = ((String)map.get("ArrP_name")).split(",");
	      String[] ArrP_code = ((String)map.get("ArrP_code")).split(",");
	     // String[] ArrP_price = ((String)map.get("ArrP_price")).split(",");
	      //String[] ArrP_saleprice = ((String)map.get("ArrP_saleprice")).split(",");
	      String[] ArrP_count = ((String)map.get("ArrP_count")).split(",");
	      //String[] ArrP_sumprice = ((String)map.get("ArrP_sumprice")).split(","); 
	      int check =0;
	      System.out.println("length: "+ArrP_count.length);
	      for(int i=0; i<ArrP_count.length;i++) {//db 수량 비교 for문
	    	  System.out.println(i+"바퀴");
	    	  check = SellOrderDao.CheckCount(ArrP_code[i]) ;
	    	  if(Integer.parseInt(ArrP_count[i]) > check) {
	    		  check=0;
	    		  break;
	    	  }	  
	      }
	     
	      //String product_code = (String) map.get("product_code");
	      
	      System.out.println("check" +check);
	        if(check==0) { 
	           //System.out.println("check>0 취소가 되어라...");
	           System.out.println("imp_uid "+imp_uid);
	           paymentService.payMentCancle(token, imp_uid, "오류");
	           return "0"; 
	           } 
	        else { 
	           String user_id = (String)map.get("user_id"); 
	           System.out.println("user_id"+user_id);
	           String user_phone = (String)map.get("selectTel") + "-" +  (String)map.get("userTel01") + "-" + (String)map.get("userTel02"); 
	           System.out.println("user_phone"+user_phone);
	           String user_name = (String)map.get("user_name"); 
	           System.out.println("user_name"+user_name);
	           String user_email = (String)map.get("user_email01") + "@" + (String)map.get("selectEmail"); 
	           System.out.println("user_email"+user_email);
	           String bill_order = (String)map.get("bill_order"); 
	           System.out.println("bill_order"+bill_order);
	           String sell_post = (String)map.get("zipcode"); 
	           System.out.println("sell_post"+sell_post);
	           String sell_address = (String)map.get("address1") + " " + (String) map.get("address2"); 
	           System.out.println("sell_address"+sell_address);
	           int bill_deliver = Integer.parseInt(map.get("fee").toString());// 오브젝트형 -> 인트 하는법 : 스트링 변환후     parseInt
	           System.out.println("bill_deliver"+bill_deliver);
	           int bill_total = bill_deliver +
	           Integer.parseInt(map.get("total_price").toString());// 오브젝트형 -> 인트 하는법 :  스트링 // 변환후 parseInt 
	           System.out.println("bill_total"+bill_total);
	           //여기서부터 수정하면 된다 위에까지는 다똑같다.
	           for(int i=0; i<ArrP_count.length;i++) {//db 수량 비교 for문
	        	   // s_code, s_name, s_cate,s_price(판매가)
	        	    String product_code= ArrP_code[i];
	        	    ProductDTO  Pdto = SellOrderDao.Sell_Product(product_code); 
	        	    Pdto.setProduct_name(ArrP_name[i]);
		   			Pdto.setProduct_amount(Integer.parseInt(ArrP_count[i]));
		   			SellOrderDao.Sell_Result(Pdto, user_id, user_phone, user_name, user_email, bill_order, sell_address,  sell_post, bill_deliver, bill_total);	  
	        	   System.out.println("Pdto"+Pdto);
	 	      }
	          // ProductDTO  Pdto = SellOrderDao.Sell_Product(product_code); 
	           //System.out.println("Pdto"+Pdto);
	           //23.02.28test SellOrderDao.Sell_Result(Pdto, user_id, user_phone, user_name, user_email, bill_order, sell_address,    sell_post, bill_deliver, bill_total);
	           return "1";
	        }

		  
		 

	}
	
	/*
	 * @Transactional
	 * 
	 * @RequestMapping("test.do") public String test(HttpServletRequest request) {
	 * System.out.println("확인"); HttpSession session = request.getSession(); String
	 * user_id = (String)session.getAttribute("user_id");
	 * SellOrderDao.test(user_id); System.out.println("재확인"); return
	 * "/shop/buy_result";
	 * 
	 * }
	 */
	

	@RequestMapping("SellFail.do") 
	public String SellFail(@RequestParam String product_code,HttpServletRequest request) { 
		HttpSession session =
		request.getSession(); String user_id = (String)
		session.getAttribute("user_id"); System.out.println("SellFail"+product_code);
		System.out.println("SellFail user_id"+user_id);
		SellOrderDao.SellFail(product_code, user_id); return
		"redirect:/shop/list.do";
	
	 }


	@RequestMapping("BuyResult.page")
	public String buyResult_page() {

		return "/shop/buy_result";

	}

	@RequestMapping("SellResult.page")
	public String sellResult_page() {

		return "/shop/sell_result";

	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
