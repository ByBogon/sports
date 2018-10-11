package com.bybogon.sports.controller.ajax;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.vo.Sports_Grp;
import com.bybogon.sports.vo.Sports_Member;

@RestController
public class AjaxGroupController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@Autowired
	private MemberDAO mDAO;
	
	
	@Transactional
	@RequestMapping(value = "makeOneGroup.do", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int openGroupP(
			@RequestParam(value="grp_name") String grp_name,
			@RequestParam(value="grp_leader") String grp_leader,
			@RequestParam(value="memList") String[] memList,
			@RequestParam(value="txt_set_center", required = false) String center,
			@RequestParam(value="txt_addr", required = false) String addr,
			@RequestParam(value="txt_addr_center", required = false) String addr_center,
			HttpServletRequest request, HttpSession session) {
		System.out.println(grp_name);
		System.out.println(grp_leader);
		System.out.println(memList);
		System.out.println(center);
		System.out.println(addr);
		System.out.println(addr_center);
		int ret2 = 0;
		grp_leader = (String) session.getAttribute("SID");
		System.out.println(grp_leader);
		
		String final_center = null;
		if ( !(center.equals(null)) ) {
			final_center = center;
		} else if ( ( !(addr.equals("")) ) && ( !(addr_center.equals("")) ) ) {
			final_center = addr + "/ " + addr_center;
		} else if (addr.equals(null)) {
			final_center = addr_center;
		} else if (addr_center.equals(null)) {
			final_center = addr;
		}
		Sports_Grp vo = new Sports_Grp(grp_name, grp_leader, final_center);
		gDAO.makeOneGrp(vo);
		List<String> memIdList = new ArrayList<String>(Arrays.asList(memList));
		memIdList.add(grp_leader);
		int sportsGrpNo = gDAO.selectRecentSportsGrpNo(grp_name);
		int no = gDAO.selectRecentGrpMemNo();
		for(String mem : memIdList) {
			no++;
			ret2 = gDAO.makeGrpMems(mem, no, sportsGrpNo);
		}
		return ret2;
	}
	
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
