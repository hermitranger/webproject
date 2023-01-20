package com.example.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.web.model.UserDAO;
import com.example.web.model.UserDTO;

@Controller
@RequestMapping("controller")

public class JoinController {

	@Autowired
	UserDAO userDao;

	@RequestMapping("/")
	public String main() {
		return "index";
	}

	@RequestMapping("join.page")
	public String joinpage() {
		return "login/join";
	}
	
	@RequestMapping("search.page")
	public String search() {
		return "search";
	}
	
	@RequestMapping("search_search.do")
	public @ResponseBody String search_search(String search){
		
		System.out.println(search);
		String str="%"+search+"%";
		System.out.println(str);
		List<String> list= userDao.search_search(str);
		System.out.println(list);
		String html="";
		
		for(int i=0; i<list.size();i++) {
			
			html+=list.get(i)+"<br>";
			
		}
		
		System.out.println(list);
		
		return html;
		
	}
	

//	@RequestMapping("join.do")
//	public String join(UserDTO dto) {
//		
//
//		System.out.println(dto);
//		userDao.insert(dto);
//		
//		return "index";
//		
//	}

//	,String user_id,String user_passwd,String user_name,
//	String user_birth, String user_gender, String user_email, String user_phone

	@RequestMapping("join.do")
	public String join(UserDTO dto, Model model) {
//	public String join(@RequestParam UserDTO dto) {

		

		String user_id = dto.getUser_id();

		String expid = "^[a-z0-9]{4,10}$";

		// 이메일 \w+@\w+\.\w+(\.\w+)?

		// .은 어떤 문자 하나를 의미 dot을 표현 하려면\\. abc pattern ab. =>true
		// ? 문자가 0번 혹은 1번 발생 * 문자가 0번 이상 발생 + 문자가 1번 이상 발생
		// 핸드폰 번호 ^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$
		// 전화 번호 ^\d{2,3}-\d{3,4}-\d{4}$
		// boolean test= expid.matches(user_id);

		boolean test = Pattern.matches(expid, user_id);

		System.out.println("test:" + test);

		if (test) {

			int result = userDao.idcheck(user_id);
			System.out.println("result:" + result);

			if (result == 1) {

				dto.setUser_id("");

				model.addAttribute("message", "사용할 수 없는 아이디 입니다.");
				// return "forward:/controller/join.page";
				model.addAttribute("dto", dto);

				return "join";

			}

			userDao.insert(dto);

			return "redirect:/"; // redirect===> 같은 컨트롤로 주소로 이동, 쓸 때 주의

		} else {

			dto.setUser_id("");
			model.addAttribute("message", "영문소문자와 숫자만 입력해 주세요");
			// return "forward:/controller/join.page";
			model.addAttribute("dto", dto);

			return "join";

		}

	}

	@RequestMapping("idcheck.do")
	@ResponseBody
	public Map<String, String> idcheck(String user_id, Model model) { // httpservlet 객체 확장==>request,response ==>model

		int result = userDao.idcheck(user_id);
		System.out.println("cont:" + result);
		if (result == 1) {

			Map<String, String> map = new HashMap<>();
//			map.put("message", "사용할 수 없는 아이디 입니다.");
//			map.put("result1", user_id);
//			model.addAttribute("map",map);

			// model.addAttribute("message", "사용할 수 없는 아이디입니다."); //model.addAttribute==>jsp
			// request.getAttribute로 값 받을 수 있음
			map.put("message", "사용할 수 없는 아이디입니다.");
			map.put("userid", "");
			// model.addAttribute("result1",user_id);
			// String str=(String)model.getAttribute("message");
//			System.out.println(str);
			// String str="";
			return map;
//			return model;

		} else {

			Map<String, String> map = new HashMap<>();
//			map.put("message", "사용할 수 있는 아이디 입니다.");
//			map.put("result2", user_id);
//			model.addAttribute("map",map);
			// model.addAttribute("message","사용할 수 있는 아이디입니다.");
			map.put("message", "사용할 수 있는 아이디입니다.");
			map.put("userid", user_id);
//			model.addAttribute("result2",user_id);
			// String str=(String)model.getAttribute("message");
			// String str=user_id;
			// System.out.println(str);
			// return str;
			return map;
		}

	}

}
