package com.bybogon.sports.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CenterController {
	
	@RequestMapping(value = "/center_location.do", method=RequestMethod.GET)
	public String centerLocation() {
		return "center_location";
	}
}
