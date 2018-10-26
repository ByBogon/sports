package com.bybogon.sports.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.dao.CenterDAO;
import com.bybogon.sports.vo.Sports_Infrm_Center;

@Controller
public class AdminController {
	
	@Autowired
	private CenterDAO cDAO;
	
	@RequestMapping(value = "admin.do", method = RequestMethod.GET)
	public String admin(
			@RequestParam(value="menu", defaultValue="0") int menu,
			Model model) {
		
		if (menu == 0) {
			model.addAttribute("menu", menu);
		} else if (menu == 1) {
			
		} else if (menu == 2) {
			List<Sports_Infrm_Center> list = cDAO.selectUpdatableCenters();
			model.addAttribute("mList", list);
		
		} else if (menu == 3) {
			
		} else {
			
		}
		return "admin";
	}

}
