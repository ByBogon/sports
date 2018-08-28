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
	private MemberDAO mDao;
	
	@RequestMapping(value = "ajax_search_member.do", method=RequestMethod.GET,
			produces="application/json")
	public @ResponseBody List<Sports_Member> searchMember(
			@RequestParam(value="mem") String mem) {
		System.out.println(mem);
		List<Sports_Member> list = mDao.selectMemberList(mem);
		
		return list;
	}
}
