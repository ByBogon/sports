package com.bybogon.sports.controller.ajax;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.vo.Sports_Member;

@RestController
public class AjaxMemberController {

	@Autowired
	private MemberDAO mDAO;
	
	@RequestMapping(value = "ajax_search_member.do", method=RequestMethod.GET,
			produces="application/json")
	public @ResponseBody List<Sports_Member> searchMember(
			@RequestParam(value="mem") String mem,
			@RequestParam(value="myid") String myid,
			@RequestParam(value="myname") String myname) {
		System.out.println(mem);
		System.out.println(myid);
		System.out.println(myname);
		List<Sports_Member> list = mDAO.searchMemberList(mem, myid, myname);
		for(Sports_Member vo : list) {
			System.out.println(vo.getMem_id());
		}
		return list;
	}
	
	@RequestMapping(value = "ajax_id_check.do", method = RequestMethod.GET,
			produces="application/json")
	public @ResponseBody int AjaxIdCheck(
			@RequestParam(value="id") String id) {
		
		int ret = mDAO.ajaxIdCheck(id);
		return ret;
		
	}
}
