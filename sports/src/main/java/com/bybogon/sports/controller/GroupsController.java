package com.bybogon.sports.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.dao.BoardDAO;
import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.vo.Sports_Brd;
import com.bybogon.sports.vo.Sports_Grp;

@Controller
public class GroupsController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@Autowired
	private BoardDAO bDAO;
	
	@RequestMapping(value = "groups.do", method = RequestMethod.GET)
	public String main() {
		
		return "groups";
	}
	
	@RequestMapping(value = "open_group.do", method = RequestMethod.GET)
	public String openGroup(Model model, 
			HttpSession session, HttpServletRequest request) {
		String id = (String) session.getAttribute("SID");
		if (id == null) {
			return "redirect:login.do";
		}
		List<String> list = new ArrayList<String>();
		list.add("스쿼시");
		list.add("농구");
		list.add("테니스");
		model.addAttribute("list", list);
		
		return "open_group";
	}

	
	@RequestMapping(value = "myGroups.do", method = RequestMethod.GET)
	public String myGroup(HttpSession session, Model model) {
		String id = (String) session.getAttribute("SID");
		System.out.println(id);
		if (id == null) {
			return "redirect:login.do";
		} else {
			List<Sports_Grp> list = gDAO.selectMyGroups(id);
			model.addAttribute("list", list);
			return "myGroups";
		}
	}
	
	@RequestMapping(value = "allGroups.do", method = RequestMethod.GET)
	public String allGroup(HttpSession session, Model model) {
		String id = (String) session.getAttribute("SID");
		System.out.println(id);
		if (id == null) {
			return "redirect:login.do";
		} else {
			
			List<Sports_Grp> list = gDAO.selectAllGroups();
			model.addAttribute("list", list);
			return "allGroups";
		}
	}
	
	@RequestMapping(value = "group_content.do", method = RequestMethod.GET)
	public String groupContent(
			@RequestParam(value="grp_no", defaultValue="0") int grp_no,
			HttpSession session,
			Model model) {
		Sports_Grp vo = gDAO.selectGroupOne(grp_no);
		List<Map<String, Object>> mem_list = gDAO.selectMemsOfGroup(grp_no);
		List<Sports_Brd> board = bDAO.selectBoardOne(grp_no);
		
		if(vo != null) {
			model.addAttribute("vo", vo);
			model.addAttribute("list", mem_list);
			model.addAttribute("board", board);
			return "group_content";
		} else {
			return "sports";
		}
	}
}
