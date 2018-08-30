package com.bybogon.sports.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bybogon.sports.vo.Sports_Grp;

@Controller
public class GroupsController {
	
	@RequestMapping(value = "groups.do", method = RequestMethod.GET)
	public String main() {
		
		return "groups";
	}
	@RequestMapping(value = "open_group.do", method = RequestMethod.GET)
	public String openGroup(Model model, 
			HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		System.out.println(session);
		if (session == null) {
			System.out.println("null");
		}
		model.addAttribute("vo", new Sports_Grp());
		return "open_group";
	}
}
