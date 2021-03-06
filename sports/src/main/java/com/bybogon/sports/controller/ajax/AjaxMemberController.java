package com.bybogon.sports.controller.ajax;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.AdminDAO;
import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.func.AES256Encrypt;
import com.bybogon.sports.vo.Sports_Member;

@RestController
public class AjaxMemberController {
	String key = "1z2x3cqawsedrf5tgbvh"; //키는 16자리 이상
	String amazonUrl = "https://s3.ap-northeast-2.amazonaws.com/";
	
	@Autowired
	private MemberDAO mDAO;
	
	
	@RequestMapping(value = "ajax_block_account.do", method = RequestMethod.POST)
	public int resignAccount(
			@RequestParam(value = "id") String id,
			@RequestParam(value = "pw") String pw,
			HttpSession session) {
		
		int ret = 0;
		try {
			AES256Encrypt aes256 = new AES256Encrypt(key);
			String encPw = aes256.aesEncode(pw);
			ret = mDAO.blockMember(id, encPw);
			session.removeAttribute("SID");
			session.removeAttribute("SNAME");
			session.invalidate();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ret;
	}
	
	@RequestMapping(value = "ajax_add_myCenter.do", method = RequestMethod.GET)
	public int addMyCenter(
			@RequestParam(value="id") String id,
			@RequestParam(value="addr") String addr) {
		System.out.println(addr);
		int ret = mDAO.addMyCenter(id, addr);
		
		return ret;
	}
	
	@RequestMapping(value = "ajax_add_grp_mem.do", 
			method = {RequestMethod.GET, RequestMethod.POST},
			produces="application/json")
	public @ResponseBody List<Sports_Member> addGrpMem(
			@RequestParam(value="id_list") String[] id_list) {
		System.out.println("id_list length: " + id_list.length);
		for(String a : id_list) {
			System.out.println("id_list: "+a);
		}
		
		List<Sports_Member> list = mDAO.selectMemberList(id_list);
		
		return list;
	}

	@RequestMapping(value = "ajax_grp_mem_list.do", method = RequestMethod.GET,
			produces="application/json")
	public @ResponseBody List<Sports_Member> grpMemList(
			@RequestParam(value="no") int sportsGenreNo,
			@RequestParam(value="mem_id") String mem_id,
			@RequestParam(value="idList", required=false) String[] ids) {
		System.out.println(sportsGenreNo);
		System.out.println(mem_id);
		
		List<Sports_Member> list = new ArrayList<Sports_Member>();
		if(ids == null) {
			list = mDAO.showAllMemberList(sportsGenreNo, mem_id);
			return list;
		} else {
			List<String> idList = new ArrayList<String>(Arrays.asList(ids));
			System.out.println(ids.length);
			idList.add(mem_id);
			for(String a :idList) {
				System.out.println("idList: "+a);
			}
			list = mDAO.showAddableMemberList(sportsGenreNo, idList);
			System.out.println(list.size());
			return list;
		}
	}
	
	@RequestMapping(value = "ajax_search_member.do", method = RequestMethod.GET,
			produces="application/json")
	public @ResponseBody List<Sports_Member> searchMember(
			@RequestParam(value="mem") String mem,
			@RequestParam(value="myid") String myid,
			@RequestParam(value="myname") String myname,
			@RequestParam(value="idList", required=false) String[] ids) {
		System.out.println(mem);
		System.out.println(myid);
		System.out.println(myname);
		
		List<String> idList = new ArrayList<String>(Arrays.asList(ids));
		List<Sports_Member> list = mDAO.searchAddableMemberList(mem, myid, myname, idList);
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
	
	@RequestMapping(value = "ajaxPwCheck.do", method = RequestMethod.POST,
			produces="application/json")
	public @ResponseBody Map<String, Object> AjaxPwCheck(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw) {
		try {
			
			AES256Encrypt aes256 = new AES256Encrypt(key);
			String encPw = aes256.aesEncode(pw);
		
			Map<String, Object> map = mDAO.ajaxPwCheck(id, encPw);
			return map;
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	@RequestMapping(value = "ajaxSelectMemOne.do", method = RequestMethod.POST,
			produces="application/json")
	public @ResponseBody Map<String, Object> ajaxSelectMemOne(
		@RequestParam(value="mem_id") String id) {
		System.out.println(id);
		Map<String, Object> map = mDAO.ajaxSelectMemOne(id);
		
		System.out.println(map.get("MEM_EMAIL"));
	
		return map;
	}
	
	@RequestMapping(value = "ajaxUpdateMemOne.do", method = RequestMethod.POST)
	public String ajaxUpdateMemOne(
			@RequestParam(value="mem_name") String name,
			@RequestParam(value="mem_pw") String pw,
			@RequestParam(value="mem_age") int age,
			@RequestParam(value="mem_detail") String detail,
			@RequestParam(value="mem_email", required=false) String email,
			@RequestParam(value="mem_img", required=false) String img,
			HttpSession session) {
		try {
			Sports_Member vo;
			String id = (String) session.getAttribute("SID");
			int ret;
			String key = "1z2x3cqawsedrf5tgbvh"; //키는 16자리 이상
			AES256Encrypt aes256 = new AES256Encrypt(key);
			String encPw = aes256.aesEncode(pw);
			
			img = amazonUrl+img;
			if( (pw.trim() == "") || ((pw.trim()).equals("")) || (pw == null) ) {
				vo = new Sports_Member(id, null, name, age, email, img, detail);
				ret = mDAO.ajaxUpdateMemOne(vo);
				if (ret > 0) {
					return "myPage";
				} else {
					return "null";
				}
			} else {
				vo = new Sports_Member(
						id, encPw, name, age, email, img, detail);
				ret = mDAO.ajaxUpdateMemOne(vo);
				if (ret > 0) {
					return "success";
				} else {
					return "false";
				}
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}
