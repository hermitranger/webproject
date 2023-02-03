package com.example.web.controller;
//package com.example.teamproject.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.example.teamproject.model.UserDAO;
//import com.example.teamproject.model.UserDTO;
//
//@Controller
//@RequestMapping("controller")
//
//public class Joincontroller2 {
//	
//	@Autowired
//	UserDAO userDao;
//	
//	@RequestMapping("/")
//	public String main() {
//		return "redirect:/index";
//	}
//	
//	@RequestMapping("join.page")
//	public String joinpage() {
//		return "join";
//	}
//	
//	@RequestMapping("join.do")
//	public String join(UserDTO dto) {
//		
//		userDao.insert(dto);
//		
//		return "index";
//		
//	}
//	
//	@RequestMapping("idcheck.do")
//	@ResponseBody
//	public String idcheck(String user_id,Model model) {
//		
//		int result=userDao.idcheck(user_id);
//		System.out.println("cont:"+result);
//		if(result==1) {
//			
//			model.addAttribute("message", "사용할 수 없는 아이디입니다.");
//			String str=(String)model.getAttribute("message");
//			System.out.println(str);
//			return "join";
//			
//		}else {
//			model.addAttribute("message","사용할 수 있는 아이디입니다.");
//			String str=(String)model.getAttribute("message");
//			//System.out.println(str);
//			return str;  //responsebody를 붙여서 데이터로 전달해도 ajax에서 활용가능!
//			//안되면 빈페이지 a를 경유해서 표시!
//			//return "a";
//		}
//		
//		
//	}
//
//}
