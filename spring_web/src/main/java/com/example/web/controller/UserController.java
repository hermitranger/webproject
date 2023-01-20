package com.example.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BuyBillDTO;
import com.example.web.model.ProductDAO;
import com.example.web.model.ProductDTO;
import com.example.web.model.SellBillDTO;
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

	@RequestMapping("/") // https://jiwontip.tistory.com/77 참고
	public ModelAndView main(HttpServletRequest request, ModelAndView mav) throws Exception {
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");

		if (user_id == null) {

			mav.setViewName("/main");
			List<ProductDTO> new_list = productDao.new_list();
			mav.addObject("list", new_list);
			return mav;

		/*
		 * else if (user_id.equals("admin")) {// ==을쓰면 주소값을 비교하기 때문에 , equals("admin")을
		 * 사용해야함 mav.setViewName("/adminmain"); return mav;
		 */
		} else {
			mav.setViewName("/main");
			return mav;
		}

	}

	@RequestMapping("menu.do")
	public String userList1(Model model) {
		return "include/menu";
	}

	@RequestMapping("login.do")
	public String login() {
		return "login/login"; // login.jsp 페이지로 이동
	}

	@RequestMapping("login_check.do")
	public ModelAndView login_check(UserDTO dto, HttpSession session, ModelAndView mav) {
		String user_name = userDao.login(dto);	
		int user_check = userDao.check(dto);

		if (user_name != null) { // 로그인 성공하면 세션변수 등록
			session.setAttribute("user_id", dto.getUser_id());
			session.setAttribute("user_name", user_name);			
			session.setAttribute("user_check", user_check);
		}

		if (user_name != null) { // 로그인 성공하면
			if (dto.getUser_check() >= 0) {
				mav.setViewName("main");
				System.out.println("user_check : " + user_check);
			} else {
				mav.setViewName("login/login");
				mav.addObject("message", "withdrawal");
				session.invalidate();
			}
		} else {
			mav.setViewName("login/login"); // login.jsp로 이동
			mav.addObject("message", "error");

		}
		return mav;
	}

	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		session.invalidate();
		mav.setViewName("login/login");
		mav.addObject("message", "logout");
		return mav;
	}

	@RequestMapping("user/write.do")
	public String write() {
		return "user/write";
	}

	@RequestMapping("user/insert.do")
	public String insert(@ModelAttribute UserDTO dto) {
		userDao.insert(dto);
		return "redirect:/user/list.do";
	}

	/*
	 * @RequestMapping("user/view.do") public String view(@RequestParam(defaultValue
	 * = "") String user_id, Model model) { model.addAttribute("dto",
	 * userDao.detail(user_id)); return "user/detail"; }
	 */
	/*
	 * @RequestMapping("user/delete.do") public String
	 * delete(@RequestParam("user_id") String user_id, @RequestParam("user_passwd")
	 * String passwd, Model model) { boolean result = userDao.check_passwd(user_id,
	 * passwd); if (result) { userDao.delete(user_id); return
	 * "redirect:/user/list.do"; } else { model.addAttribute("message",
	 * "비밀번호가 일치하지않습니다."); model.addAttribute("dto", userDao.detail(user_id));
	 * return "user/detail"; } }
	 */
	@RequestMapping("user/update.do")
	public String update(@ModelAttribute UserDTO dto, Model model) {
		boolean result = userDao.check_passwd(dto.getUser_id(), dto.getUser_passwd());
		if (result) {
			userDao.update(dto);
			return "redirect:/user/list.do";
		} else {
			UserDTO dto2 = userDao.detail(dto.getUser_id());
			model.addAttribute("dto", dto);
			model.addAttribute("message", "비밀번호가 일치하지않습니다.");
			return "user/detail";
		}
	}

	@RequestMapping("user.page")
	public String user_page(HttpSession session) {

		System.out.println(session.getAttribute("user_id"));
		if (session.getAttribute("user_id") != null) {

			return "login/detail";

		} else {

			return "login/login";
		}
	}

	@RequestMapping("find.do")
	public String findPageView() {
		return "login/find";
	}

	// 아이디 찾기 페이지 이동
	@RequestMapping("findid.do")
	public String findIdView() {
		return "login/find_id";
	}

	// 아이디 찾기 실행
	@RequestMapping("findid_check.do")
	public ModelAndView findid_check(UserDTO dto, HttpSession session) {
		String user_id = userDao.findid(dto); // 로그인 체크
		if (user_id != null) { // 일치하면 id 세션 변수 등록.
			session.setAttribute("user_id", user_id);
		}
		ModelAndView mav = new ModelAndView();
		if (user_id != null) { // 로그인 성공하면
			mav.setViewName("login/find_idresult"); // find_result.jsp로 이동
		} else { // 로그인 실패하면
			mav.setViewName("login/find_id"); // login.jsp로 이동
			mav.addObject("message", "이름 혹은 아이디가 일치하지 않습니다.");
		}
		return mav;
	}

	@RequestMapping("findpasswd.do")
	public String findPasswdView() {
		return "login/find_passwd";
	}

	@RequestMapping("findpasswd_check.do")
	public ModelAndView findpasswd_check(UserDTO dto, HttpSession session) {
		String user_id = userDao.findid(dto); // 로그인 체크
		String user_passwd = userDao.findpasswd(dto);
		if (user_id != null) { // 일치하면 id 세션 변수 등록.
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_passwd", user_passwd);
		}
		ModelAndView mav = new ModelAndView();
		if (user_id != null) { // 로그인 성공하면
			mav.setViewName("login/find_passwdresult"); // find_result.jsp로 이동
		} else { // 로그인 실패하면
			mav.setViewName("login/find_passwd"); // login.jsp로 이동
			mav.addObject("message", "이름 혹은 아이디가 일치하지 않습니다.");
		}
		return mav;
	}

	@RequestMapping("check_passwd.do")
	public String check_passwd(HttpSession session, String user_passwd, UserDTO dto, Model model) {

//		if(session.getAttribute("user_id")==null) {
//			
//			String user_id="";
//		}

		String user_id = session.getAttribute("user_id").toString();
		boolean result = userDao.check_passwd(user_id, user_passwd);
		if (result) {

			dto = userDao.detail(user_id);
			model.addAttribute("dto", dto);

			return "login/list";

		} else {
			model.addAttribute("message", "비밀번호를 확인해 주세요");
			return "login/detail";
		}

	}

	@RequestMapping("user_update.do")
	public String user_update(UserDTO dto) {

		userDao.user_update(dto);

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
		boolean result = userDao.check_passwd(user_id, user_passwd);

		if (result) {

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
		userDao.user_withdraw(user_id);

		session.invalidate();

		return "main";

	}
}
