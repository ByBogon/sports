package com.bybogon.sports.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.vo.Sports_Grp;

@Controller
public class SportsController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@RequestMapping(value="squash.do", method=RequestMethod.GET)
	public String sportsMain(
			@RequestParam(value="sports", defaultValue="squash") String sports,
			Model model) {
		if (sports.equals("squash")) {
			List<Sports_Grp> list = gDAO.selectThreeNewGrp();
			model.addAttribute("list", list);
			
		} else if (sports.equals("basketball")) {
			
		} else if (sports.equals("tennis")) {
			
		}
		return "squash";
	}
}
