package com.bybogon.sports.controller.ajax;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.vo.Sports_Member;

@RestController
public class AjaxGroupController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@Autowired
	private MemberDAO mDAO;
	
	@RequestMapping(value = "ajax_grp_mem_list.do", method = RequestMethod.GET,
			produces="application/json")
	public @ResponseBody List<Sports_Member> grpMemList(
			@RequestParam(value="no") int no,
			@RequestParam(value="mem_id") String mem_id,
			@RequestParam(value="idList", required=false) String[] ids) {
		System.out.println(no);
		System.out.println(mem_id);
		
		List<Sports_Member> list = new ArrayList<Sports_Member>();
		if(ids == null) {
			list = gDAO.showAllMemberList(no, mem_id);
			return list;
		} else {
			List<String> idList = new ArrayList<String>(Arrays.asList(ids));
			System.out.println(ids.length);
			idList.add(mem_id);
			for(String a :idList) {
				System.out.println("idList: "+a);
			}
			list = gDAO.showAddableMemberList(no, idList);
			System.out.println(list.size());
			return list;
		}
	}
	
	@RequestMapping(value = "ajax_add_grp_mem.do", 
			method = {RequestMethod.GET, RequestMethod.POST},
			produces="application/json")
	public @ResponseBody List<Sports_Member> addGrpMem(
			@RequestParam(value="id_list") String[] id_list) {
		System.out.println("AJAX: " + id_list.length);
		for(String a : id_list) {
			System.out.println("id_list: "+a);
		}
		
		List<Sports_Member> list = mDAO.selectMemberList(id_list);
		
		return list;
	}
}
