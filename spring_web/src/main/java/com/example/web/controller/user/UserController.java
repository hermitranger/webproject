package com.example.web.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.ProductDAO;
import com.example.web.model.ProductDTO;
import com.example.web.model.UserDAO;
import com.example.web.model.UserDTO;

//@RequestMapping은 다중요청도 가능하다!
//https://dahliachoi.tistory.com/42
//@RequestMapping(value = {"/hello", "/hello-basic"})
@Controller
public class UserController {
	@Autowired
	UserDAO userDao;

	@Autowired
	ProductDAO productDao;
	
	@RequestMapping("test")
	public String test() {
		return "include/test";
	}
		
	@RequestMapping("/") // https://jiwontip.tistory.com/77 참고
	public ModelAndView main( ModelAndView mav) throws Exception {
		
			mav.setViewName("main");
			List<ProductDTO> new_list = productDao.new_list();
			mav.addObject("list", new_list);
			return mav;

		/*
		 * else if (user_id.equals("admin")) {// ==을쓰면 주소값을 비교하기 때문에 , equals("admin")을
		 * 사용해야함 mav.setViewName("/adminmain"); return mav;
		 */
		/*
		 * } else { mav.setViewName("/main"); return mav; }
		 */

	}
	
	@RequestMapping("login.page")
	public String login() {
		return "login/login"; // login.jsp 페이지로 이동
	}

	
	@RequestMapping("login.do")
	public ModelAndView login(UserDTO dto, HttpSession session, ModelAndView mav) {
		
		
		String user_id = dto.getUser_id();
		String user_passwd = dto.getUser_passwd();
		
		boolean result = userDao.login(user_id, user_passwd);
		
		if(result == true) {
			
			UserDTO inform = userDao.detail(user_id);			
			int user_check=inform.getUser_check();
			
			if( user_check >= 0) {
				
				session.setAttribute("user_id", inform.getUser_id());
				session.setAttribute("user_name", inform.getUser_name());
				session.setAttribute("user_check", inform.getUser_check());
				List<ProductDTO> new_list = productDao.new_list();
				mav.addObject("list", new_list);
				mav.setViewName("main");
				
			}else {
				
				mav.setViewName("login/login");
				mav.addObject("message", "withdrawal");
				session.invalidate();				
			}
					
		}else {
			
			mav.setViewName("login/login");
			mav.addObject("message", "error");
		}
		
		return mav;
	}


	@RequestMapping("logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpSession session, ModelAndView mav) {
		
		session.invalidate();
		mav.setViewName("main");
		mav.addObject("message", "logout");
		return mav;
	}

	
	@RequestMapping("user.page")
	public String userPage(HttpSession session) {

		if (session.getAttribute("user_id") != null) {

			return "login/confirm";

		} else {

			return "login/login";
		}
	}

	
	// 아이디 찾기 페이지 이동
	@RequestMapping("findId.page")
	public String findIdPage() {
		return "login/find_id";
	}

	// 아이디 찾기 실행
	@RequestMapping("findIdCheck.do")
	public ModelAndView findIdCheck(UserDTO dto, HttpSession session) {
		
		
		String user_id = userDao.findId(dto); // 로그인 체크
		
		int result = userDao.emailCheck(dto.getUser_email());
		ModelAndView mav = new ModelAndView();
		
		if (result>2) {
			
			mav.setViewName("login/find_id");
			mav.addObject("message","중복된 이메일 입니다. 관리자에게 문의 하세요.");
			return mav;			
		}
		
		
		if (user_id != null) { // 일치하면 id 세션 변수 등록.
			
			session.setAttribute("user_id", user_id);
			mav.setViewName("login/find_idresult"); // find_result.jsp로 이동
		
		} else { // 아이디 찾기 실패하면
			mav.setViewName("login/find_id"); // login.jsp로 이동
			mav.addObject("message", "이름 혹은 아이디가 일치하지 않습니다.");
		}
		return mav;
	}

	
	@RequestMapping("findPasswd.page")
	public String findPasswdPage() {
		
		return "login/find_passwd";
		
	}	
	

	@RequestMapping("findPasswdCheck.do")
	public ModelAndView findPasswdCheck(UserDTO dto, HttpSession session) {
		int result = userDao.findPasswd(dto); // 로그인 체크
		String user_id= userDao.findId(dto);
		ModelAndView mav = new ModelAndView();
		System.out.println("fpc:"+result+" "+user_id);
		
		if (result==1) {
						
			mav.addObject("user_id",user_id);
			mav.setViewName("login/change_passwd");				
		
		} else { // 로그인 실패하면
			mav.setViewName("login/find_passwd"); // login.jsp로 이동
			mav.addObject("message", "이름 혹은 아이디가 일치하지 않습니다.");
		}
		return mav;
	}
	
	@Transactional
	@RequestMapping("changePasswd.do")
	public String changePasswd(String user_id,String user_passwd) {
		
		
		userDao.changePasswd(user_id,user_passwd);
		
		return "login/login";
		
	}

	@RequestMapping("confirm.do")
	public String confirm(HttpSession session, String user_passwd, UserDTO dto, Model model) {

//		if(session.getAttribute("user_id")==null) {
//			
//			String user_id="";
//		}

		String user_id = session.getAttribute("user_id").toString();
		boolean result = userDao.login(user_id, user_passwd);
		if (result) {

			dto = userDao.detail(user_id);
			model.addAttribute("dto", dto);

			return "login/detail";

		} else {
			model.addAttribute("message", "비밀번호를 확인해 주세요");
			return "login/confirm";
		}

	}
		

	@RequestMapping("user_update.do")
	public String user_update(UserDTO dto) {
		
		System.out.println("user_update_dto:"+dto);

		userDao.update(dto);

		return "main";

	}

	@RequestMapping("userwithdraw.page")
	public String withdrawPage(HttpSession session) {

		if (session.getAttribute("user_id") != null) {

			return "login/withdrawconf";

		} else {

			return "login/login";
		}

	}

	@RequestMapping("withdraw_confirm.do")
	public String withdraw_confirm(HttpSession session, String user_passwd, UserDTO dto, Model model) {

//		if(session.getAttribute("user_id")==null) {
//			
//			String user_id="";
//		}

		String user_id = session.getAttribute("user_id").toString();
		boolean result = userDao.login(user_id, user_passwd);

		if (result==true) {

			dto = userDao.detail(user_id);
			model.addAttribute("dto", dto);
			System.out.println("dto:" + dto);
			return "login/withdraw";

		} else {
			model.addAttribute("message", "비밀번호를 확인해 주세요");
			return "login/withdrawconf";
		}

	}

	@RequestMapping("user_withdraw.do")
	public String user_withdraw(UserDTO dto, HttpSession session) {

		// String user_id=dto.getUser_id();
		String user_id = session.getAttribute("user_id").toString();
		userDao.userWithdraw(user_id);

		session.invalidate();

		return "main";

	}
	
//	보류(전페이지로 이동)
//	String redirectURI=(String)session.getAttribute("redirectURI");
//	if(redirectURI!=null) {
//	mav.setViewName("redirect:"+redirectURI);
//	}else {
//	mav.setViewName("main");
//	}
//	String referer = request.getHeader("Referer");
//	session.setAttribute("redirectURI", referer);
	
	@RequestMapping("join.page")
	public String joinpage() {
		return "login/join";
	}
	
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

			int result = userDao.idCheck(user_id);			
			int resultemail= userDao.emailCheck(dto.getUser_email());
			
			
			System.out.println("result:" + result);

			if (result == 1) {

				dto.setUser_id("");

				model.addAttribute("message", "사용할 수 없는 아이디 입니다.");
				// return "forward:/controller/join.page";
				model.addAttribute("dto", dto);

				return "login/join";

			}
			
			if( resultemail == 1) {
				
				dto.setUser_email("");
				model.addAttribute("message", "사용할 수 없는 이메일 입니다.");
				model.addAttribute("dto",dto);
				return "login/join";
				
			}
			
			

			userDao.insert(dto);

			return "redirect:/"; // redirect===> 같은 컨트롤로 주소로 이동, 쓸 때 주의

		} else {

			dto.setUser_id("");
			model.addAttribute("message", "영문소문자와 숫자만 입력해 주세요");
			// return "forward:/controller/join.page";
			model.addAttribute("dto", dto);

			return "login/join";
		}
	}
	
	@RequestMapping("idcheck.do")
	@ResponseBody
	public Map<String, String> idcheck(String user_id, Model model) { // httpservlet 객체 확장==>request,response ==>model

		int result = userDao.idCheck(user_id);
		
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
	

	@RequestMapping("search.page")
	public String search() {
		return "search";
	}
	
	
	
}
