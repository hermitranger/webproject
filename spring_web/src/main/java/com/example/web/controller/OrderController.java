package com.example.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BuyOrderDAO;
import com.example.web.model.ProductDTO;
import com.example.web.model.SellOrderDAO;
import com.example.web.model.UserDTO;

@Controller
public class OrderController {

	@Autowired
	BuyOrderDAO BuyOrderDao;

	@Autowired
	SellOrderDAO SellOrderDao;

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

	@RequestMapping("OrderSell.do")
	public ModelAndView OrderSell(@RequestParam String product_code, ModelAndView mav, HttpServletRequest request) {

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

	@RequestMapping("BuyResult.do")
	@ResponseBody
	public String BuyResult(@RequestParam Map<String, Object> map) {
		String product_code = (String) map.get("product_code");
		String user_id = (String) map.get("user_id");
		String bill_order = (String) map.get("bill_order");
		String buy_post = (String) map.get("zipcode");
		String buy_address = (String) map.get("address1") + " " + (String) map.get("address2");
		int bill_deliver = Integer.parseInt(map.get("fee").toString());// ??????????????? -> ?????? ????????? : ????????? ????????? parseInt
		ProductDTO Pdto = BuyOrderDao.Buy_Product(product_code);
		UserDTO Udto = BuyOrderDao.Buy_User(user_id);
		BuyOrderDao.Buy_Result(Pdto, Udto, bill_order, buy_address, buy_post, bill_deliver);

		return "1";

	}

	@RequestMapping("SellResult.do")
	@ResponseBody
	public String SellResult(@RequestParam Map<String, Object> map) {
		String product_code = (String) map.get("product_code");
		String user_id = (String) map.get("user_id");
		System.out.println(user_id);
		String user_phone = (String) map.get("selectTel") + "-" + (String) map.get("userTel01") + "-"
				+ (String) map.get("userTel02");
		String user_name = (String) map.get("user_name");
		String user_email = (String) map.get("user_email01") + "@" + (String) map.get("selectEmail");
		String bill_order = (String) map.get("bill_order");
		String sell_post = (String) map.get("zipcode");
		String sell_address = (String) map.get("address1") + " " + (String) map.get("address2");
		int bill_deliver = Integer.parseInt(map.get("fee").toString());// ??????????????? -> ?????? ????????? : ????????? ????????? parseInt
		int bill_total = bill_deliver + Integer.parseInt(map.get("product_price").toString());// ??????????????? -> ?????? ????????? : ?????????
																								// ????????? parseInt
		ProductDTO Pdto = SellOrderDao.Sell_Product(product_code);
		SellOrderDao.Sell_Result(Pdto, user_id, user_phone, user_name, user_email, bill_order, sell_address, sell_post,
				bill_deliver, bill_total);
		// int price = Integer.parseInt(map.get("product_price").toString());//???????????? ?????????
		// ??????

		return "1";

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
