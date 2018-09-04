package com.bybogon.sports.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.vo.Sports_Grp;

@Controller
public class GroupsController {
	int ret2 = 0;
	@Autowired
	private GroupDAO gDAO;
	
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
		List<String> list = new ArrayList<String>();
		list.add("스쿼시");
		list.add("농구");
		list.add("테니스");
		model.addAttribute("list", list);
		
		return "open_group";
	}
	
	@Transactional
	@RequestMapping(value = "makeOneGroup.do", method = RequestMethod.GET)
	public String openGroupP(@RequestParam(value="grp_name") String grp_name,
			@RequestParam(value="grp_leader") String grp_leader,
			@RequestParam(value="memList") String[] memList) {
		Sports_Grp vo = new Sports_Grp(grp_name,grp_leader);
		gDAO.makeOneGrp(vo);
		int sportsGrpNo = gDAO.selectRecentSportsGrpNo(grp_name);
		int no = gDAO.selectRecentGrpMemNo();
		for(String mem : memList) {
			no++;
			ret2 = gDAO.makeGrpMems(mem, no, sportsGrpNo);
		}
		
		if (ret2 > 0) {
			return "redirect:groups.do";
		} else {
			return "redirect:open_group.do";
		}
	}
	
	@RequestMapping(value = "myGroups.do", method = RequestMethod.GET)
	public String myGroup(HttpSession session, Model model) {
		String id = (String) session.getAttribute("SID");
		if (id.equals("null")) {
			return "redirect:login.do";
		}
		List<Sports_Grp> list = gDAO.selectMyGroups(id);
		model.addAttribute("list", list);
		return "myGroup";
	}
}
