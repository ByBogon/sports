package com.bybogon.sports.controller;

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
	public String openGroup(Model model) {
		model.addAttribute("vo", new Sports_Grp());
		return "open_group";
	}
}
