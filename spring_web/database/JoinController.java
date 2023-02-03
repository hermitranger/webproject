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


@RequestMapping("controller")

public class JoinController {

	@Autowired
	UserDAO userDao;

	

	
	

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



	

}
