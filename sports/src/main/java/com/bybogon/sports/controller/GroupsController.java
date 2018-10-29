package com.bybogon.sports.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bybogon.sports.dao.BoardDAO;
import com.bybogon.sports.dao.GroupDAO;
import com.bybogon.sports.dao.impl.AwsS3DAOImpl;
import com.bybogon.sports.vo.Sports_Brd;
import com.bybogon.sports.vo.Sports_Grp;

@Controller
public class GroupsController {
	
	@Autowired
	private GroupDAO gDAO;
	
	@Autowired
	private BoardDAO bDAO;

	@Autowired
	private AwsS3DAOImpl s3DAO;
	
	@Value("${aws_namecard_bucket}")
	private String bucketName;
	
	String amazonUrl = "https://s3.ap-northeast-2.amazonaws.com/";
	String dir = "group/";
	
	
	@RequestMapping(value = "updateGrpProfile.do", method = RequestMethod.POST)
	public String updateGroupProfile(
			@RequestParam(value="grp_no") int grp_no,
			@RequestParam(value="updateGrpName") String grp_name,
			@RequestParam(value="grpProfileFile", 
				required=false, defaultValue="null") MultipartFile uploadFile,
			Model model, HttpSession session) {
		System.out.println("GRP_NO: "+grp_no);
		System.out.println("GRP_NAME: "+grp_name);
		System.out.println("GRP_FILE: "+uploadFile);
		String id = (String) session.getAttribute("SID");
		int ret;
		Sports_Grp vo;
		String S3ImgUrl;
		if ( uploadFile.isEmpty() ) {
			//이미지를 첨부 하지 않았을때
			S3ImgUrl = null;
		} else {
			dir += (grp_no+"/profile");
			System.out.println(dir);
			System.out.println(uploadFile);
			System.out.println(session);
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			String date = sdf.format(new Date());
			System.out.println(date);
			String originName = uploadFile.getOriginalFilename();
			String extension = originName.substring(originName.indexOf("."));
			String keyName = dir+"/"+id+"_"+date+extension; 
			// S3 는 하위 디렉토리 개념이 아니라 /를 통한 key들을 읽음
			// 그래서 /를 붙이면 s3 console 에서 볼때 folder가 만들어짐
			// 폴더가 실제 트리구조의 하위 디렉토리가 아니라 key 값으로 읽음
	
			s3DAO.uploadFile(uploadFile, keyName);
			S3ImgUrl = amazonUrl+bucketName+"/"+keyName;
			System.out.println(S3ImgUrl);
		}
		vo = new Sports_Grp(grp_no, grp_name, S3ImgUrl);
		ret = gDAO.updateGroupOne(vo);
		if (ret == 1) {
			model.addAttribute("msg", "그룹 프로필을 수정하였습니다.");
			model.addAttribute("url", "group_content.do?grp_no="+grp_no);
			return "alert";
		} else {
			model.addAttribute("msg", "그룹 프로필 수정에 실패하였습니다.");
			model.addAttribute("url", "group_content.do?grp_no="+grp_no);
			return "alert";
		}
	}
	
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
		List<Sports_Brd> board = bDAO.selectBoardsOfGroup(grp_no);
		
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
