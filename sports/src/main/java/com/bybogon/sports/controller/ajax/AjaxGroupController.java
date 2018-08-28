package com.bybogon.sports.controller.ajax;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.vo.Sports_Member;

@RestController
public class AjaxGroupController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@RequestMapping(value = "ajax_grp_mem_list.do", method = RequestMethod.GET,
			produces="application/json")
	public @ResponseBody List<Sports_Member>grpMemList(
			@RequestParam(value="no") int no,
			@RequestParam(value="mem_id") String mem_id) {
		System.out.println(no);
		System.out.println(mem_id);
		List<Sports_Member> list = gDAO.selectMemberList(no, mem_id);
		System.out.println(list.size());
		return list;
	}
}
