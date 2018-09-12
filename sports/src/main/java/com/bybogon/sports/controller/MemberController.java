package com.bybogon.sports.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.func.EncryptionClass;
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
		Sports_Member vo = new Sports_Member(id, EncryptionClass.convertMD5(pw), name, age, email);

		int ret = mDAO.joinMember(vo);
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
	public String login(HttpSession session) {
		String id = (String) session.getAttribute("SID");
		if(id == null) {
			return "login_v4";
		} else {
			return "redirect:sports.do";
		}
		
	}
	
	@RequestMapping(value = "login.do", method=RequestMethod.POST)
	public String loginP(@RequestParam(value="username") String id,
			@RequestParam(value="pass") String pw,
			HttpSession session, HttpServletRequest request) {
		try {
		Sports_Member vo = new Sports_Member(id, EncryptionClass.convertMD5(pw));
		vo = mDAO.loginMember(vo);
		if(vo != null) {
			if(vo.getMem_check() == 1) {
				session.setAttribute("SID", vo.getMem_id());
				session.setAttribute("SNAME", vo.getMem_name());
			
			//마지막 페이지 주소
			String backUrl = (String) session.getAttribute("BACK_URL");
			System.out.println(backUrl);
			if(backUrl.equals("login.do")) {
				backUrl = "sports.do";
			}			
			request.setAttribute("msg", "로그인 성공");
			request.setAttribute("url", backUrl);
			return "alert"; 
			} else if (vo.getMem_check() == 0) {
				System.out.println("차단된 아이디입니다. 관리자에게 문의하세요");
				return "redirect:login.do"; //login.jsp표시
			} else {
				System.out.println("아이디와 비밀번호를 확인해주세요.");
				return "redirect:login.do"; //login.jsp표시
			}
		} else {
			System.out.println("vo가 null 입니다");
			return "redirect:login.do";
		}
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "redirect:login.do";
		}
		
	}
	
	@RequestMapping(value="myPage.do", method=RequestMethod.GET)
	public String mypage(HttpSession session) {
		String id = (String) session.getAttribute("SID");
		if(id == null) {
			return "login_v4";
		} else {
			return "myPage";
		}
	}
	@RequestMapping(value="myPage.do", method=RequestMethod.POST)
	public String mypageP(@RequestParam(value="mem_name") String name,
			@RequestParam(value="mem_age") int age,
			@RequestParam(value="mem_detail") String detail,
			@RequestParam(value="mem_email1") String email1,
			@RequestParam(value="mem_email2") String email2,
			HttpSession session) {
		System.out.println("1: "+name);
		System.out.println("2: "+age);
		System.out.println("3: "+detail);
		System.out.println("4: "+email1);
		System.out.println("5: "+email2);
		String id = (String) session.getAttribute("SID");
		Sports_Member vo = new Sports_Member(
				id, name, age, email1+email2, null, detail);
		
		int ret = mDAO.ajaxUpdateMemOne(vo);
		if(ret > 0) {
			return "myPage";
		} else {
			return "null";
		}
	}
	
	
}
