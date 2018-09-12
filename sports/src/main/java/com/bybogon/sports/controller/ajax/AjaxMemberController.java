package com.bybogon.sports.controller.ajax;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.MemberDAO;
import com.bybogon.sports.func.EncryptionClass;
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
	
	@RequestMapping(value = "ajaxPwCheck.do", method = RequestMethod.POST,
			produces="application/json")
	public @ResponseBody Map<String, Object> AjaxPwCheck(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw) {
		System.out.println(id);
		System.out.println(pw);
		pw = EncryptionClass.convertMD5(pw);
		System.out.println(pw);
		Map<String, Object> map = mDAO.ajaxPwCheck(id, pw);
		return map;
	}
	
	@RequestMapping(value = "ajaxSelectMemOne.do", method = RequestMethod.POST,
			produces="application/json")
	public @ResponseBody Map<String, Object> ajaxSelectMemOne(
		@RequestParam(value="mem_id") String id) {
		System.out.println(id);
		Map<String, Object> map = mDAO.ajaxSelectMemOne(id);
	
		return map;
	}
	
	@RequestMapping(value = "ajaxUpdateMemOne.do", method = RequestMethod.POST)
	public String ajaxUpdateMemOne(
			@RequestParam(value="mem_name") String name,
			@RequestParam(value="mem_age") int age,
			@RequestParam(value="mem_detail") String detail,
			@RequestParam(value="mem_email1") String email1,
			@RequestParam(value="mem_email2") String email2,
			@RequestParam(value="mem_img", required=false, defaultValue="null") String img,
			HttpSession session) {
		String amazonUrl = "https://s3.ap-northeast-2.amazonaws.com/";
		System.out.println("1: "+name);
		System.out.println("2: "+age);
		System.out.println("4: "+detail);
		System.out.println("5: "+email1);
		System.out.println("5: "+email2);
		img = amazonUrl+img;
		System.out.println("6: "+img);
		String id = (String) session.getAttribute("SID");
		Sports_Member vo = new Sports_Member(
				id, name, age, email1+email2, img, detail);
		
		int ret = mDAO.ajaxUpdateMemOne(vo);
		if (ret > 0) {
			return "success";
		} else {
			return "false";
		}
	}
}
