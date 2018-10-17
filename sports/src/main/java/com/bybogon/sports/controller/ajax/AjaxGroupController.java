package com.bybogon.sports.controller.ajax;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.CenterDAO;
import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.vo.Sports_Grp;
import com.bybogon.sports.vo.Sports_Infrm_Center;
import com.bybogon.sports.vo.Sports_Member;

@RestController
public class AjaxGroupController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private CenterDAO cDAO;
	
	@RequestMapping(value = "ajaxResignCurGrpMem.do", method = RequestMethod.GET)
	public int resignGrpMem(
			@RequestParam(value="grp_no") int grp_no,
			@RequestParam(value="cur_id") String cur_id) {
		int ret = gDAO.resignGrpMem(grp_no, cur_id);
		return ret;
	}
	
	@RequestMapping(value = "ajaxAddExtraGrpMem.do", method = RequestMethod.GET)
	public int addExtraGrpMem(
			@RequestParam(value="grp_no") int grp_no,
			@RequestParam(value="extra_id") String extra_id) {
		int no = gDAO.selectRecentGrpMemNo();
		no += 1;
		int ret = gDAO.addExtraGrpMem(no, grp_no, extra_id);
		return ret;
	}
	
	@RequestMapping(value = "makeOneGroup.do", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody int openGroupP(
			@RequestParam(value="grp_name") String grp_name,
			@RequestParam(value="grp_leader") String grp_leader,
			@RequestParam(value="grp_detail") String grp_detail,
			@RequestParam(value="memList") String[] memList,
			@RequestParam(value="txt_set_center", 
				required = false, defaultValue="") String center,
			@RequestParam(value="txt_addr", 
				required = false, defaultValue="") String addr,
			@RequestParam(value="txt_name_center", 
				required = false, defaultValue="") String name_center,
			HttpServletRequest request, HttpSession session) {
		System.out.println("grp_detail: "+grp_detail);
		int ret = 0;
		int centerNo;
		grp_leader = (String) session.getAttribute("SID");
		List<String> memIdList = new ArrayList<String>(Arrays.asList(memList));
		memIdList.add(grp_leader);
		
		String final_center = null;
			
		if ( !(center.equals("")) ) {
			final_center = center;
		} else if ( ( !(addr.equals("")) ) && ( !(name_center.equals("")) ) ) {
			final_center = addr + "/ " + name_center;
		} else if (addr.equals("")) {
			final_center = name_center;
		} else if (name_center.equals("")) {
			final_center = addr;
		}
		
		Sports_Infrm_Center cVO;
		Sports_Grp vo;
		if ( center.equals("") ) {
			if ( !(addr.equals("")) ) {
				cVO = new Sports_Infrm_Center(name_center, addr);
			} else {
				cVO = new Sports_Infrm_Center(name_center);
			}
			cDAO.insertInfrmCenterOneByGrp(cVO);
			centerNo = cVO.getInfrm_center_no();

			System.out.println("CENTER NO1: "+centerNo);
		} else {
			Map<String, Object> map = cDAO.selectCenterOne(center);
			centerNo = (Integer) (map.get("CENTER_NO"));
			System.out.println("CENTER NO2: "+centerNo);
		}
		vo = new Sports_Grp(grp_name, grp_leader, grp_detail, final_center, centerNo);

		gDAO.makeOneGrp(vo);
		int grp_no = vo.getGrp_no();
		int no = gDAO.selectRecentGrpMemNo();
		Iterator<String> it = memIdList.iterator();
		int i = 0;
		while(it.hasNext()) {
			String mem = it.next();
			System.out.println(i++);
			System.out.println(mem);
			no++;
			if( it.hasNext() ) {
				ret = gDAO.makeGrpMems(mem, no, grp_no);
			} else {
				System.out.println(mem);
				gDAO.makeGrpMemsForLeader(mem, no, grp_no);
				int grp_mem_no = gDAO.selectRecentGrpMemNo();
				ret = gDAO.insertGrpLeader(grp_mem_no); 
			}
		}
		return ret;
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
