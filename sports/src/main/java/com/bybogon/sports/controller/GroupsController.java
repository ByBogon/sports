package com.bybogon.sports.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GroupsController {
	
	@RequestMapping(value = "groups.do", method = RequestMethod.GET)
	public String main() {
		return "groups";
	}
	@RequestMapping(value = "open_group.do", method = RequestMethod.GET)
	public String openGroup() {
		return "open_group";
	}
}
