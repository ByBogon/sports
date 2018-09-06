package com.bybogon.sports.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.vo.Sports_Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDAO mDAO = null;
	
	@RequestMapping(value = "/join.do", method=RequestMethod.GET)
	public String join() {
		return "join";
	}
	
	@RequestMapping(value = "/join.do", method=RequestMethod.POST)
	public String joinP(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw,
			@RequestParam(value="name") String name,
			@RequestParam(value="age") int age,
			@RequestParam(value="email") String email,
			HttpSession session) {
		Sports_Member vo = new Sports_Member(id, pw, name, age, email);
		System.out.println(vo.getMem_id());
		System.out.println(vo.getMem_pw());
		System.out.println(vo.getMem_name());
		System.out.println(vo.getMem_age());
		System.out.println(vo.getMem_email());
		int ret = mDAO.joinMember(vo);
		System.out.println(ret);
		if (ret == 1) {
			
		}
		return "redirect:sports.do";
	}
	@RequestMapping(value="logout.do",
			method = {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpSession httpsession) {
		httpsession.invalidate();
		return "redirect:sports.do";
	}
	
	@RequestMapping(value = "login.do", method=RequestMethod.GET)
	public String login() {
		return "login_v4";
	}
	
	@RequestMapping(value = "login.do", method=RequestMethod.POST)
	public String loginP(@RequestParam(value="username") String id,
			@RequestParam(value="pass") String pw,
			HttpSession session) {
		System.out.println(id);
		System.out.println(pw);
		Sports_Member vo = new Sports_Member(id, pw);
		vo = mDAO.loginMember(vo);
		if(vo != null) {
			if(vo.getMem_check() == 1) {
				session.setAttribute("SID", vo.getMem_id());
				session.setAttribute("SNAME", vo.getMem_name());
			}
			return "redirect:sports.do";
		} else {
			return "login_v4";
		}
		
	}
	
	@RequestMapping(value="myPage.do", method=RequestMethod.GET)
	public String mypage() {
		return "myPage";
	}

}
