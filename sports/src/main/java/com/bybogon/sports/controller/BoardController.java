package com.bybogon.sports.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.bybogon.sports.dao.impl.AwsS3DAOImpl;
import com.bybogon.sports.vo.Sports_Brd;

@Controller
public class BoardController {
	@Autowired
	private BoardDAO bDAO;
	
	@Autowired
	private AwsS3DAOImpl s3DAO;
	
	@Value("${aws_namecard_bucket}")
	private String bucketName;
	
	String amazonUrl = "https://s3.ap-northeast-2.amazonaws.com/";
	
	
	@RequestMapping(value="updateOneBoard.do", method=RequestMethod.POST)
	public String updateOneBoard(
			@RequestParam(value="file") MultipartFile uploadFile,
			@RequestParam(value="textarea_content") String content,
			@RequestParam(value="modal_grp_no") int grp_no,
			@RequestParam(value="modal_brd_no") int brd_no,
			HttpSession session, Model model) throws Exception {
		String dir = "board/feed/";
		String id = (String) session.getAttribute("SID");
		int ret;
		Sports_Brd vo;
		String S3ImgUrl;
		if ( uploadFile.isEmpty() ) {
			//이미지를 첨부 하지 않았을때
			S3ImgUrl = null;
		} else {
			dir += grp_no;
			System.out.println(dir);
			System.out.println(uploadFile);
			System.out.println(content);
			System.out.println(session);
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			String date = sdf.format(new Date());
			System.out.println(date);
			String originName = uploadFile.getOriginalFilename();
			String extension = originName.substring(originName.indexOf("."));
			String keyName = dir+"/"+id+"/"+id+"_"+date+extension; 
			// S3 는 하위 디렉토리 개념이 아니라 /를 통한 key들을 읽음
			// 그래서 /를 붙이면 s3 console 에서 볼때 folder가 만들어짐
			// 폴더가 실제 트리구조의 하위 디렉토리가 아니라 key 값으로 읽음
	
			s3DAO.uploadFile(uploadFile, keyName);
			S3ImgUrl = amazonUrl+bucketName+"/"+keyName;
			System.out.println(S3ImgUrl);
		}
		vo = new Sports_Brd(brd_no, content, id, grp_no, S3ImgUrl);
		ret = bDAO.updateBoardOne(vo);
		if (ret == 1) {
			model.addAttribute("msg", "피드를 수정하였습니다.");
			model.addAttribute("url", "group_content.do?grp_no="+grp_no);
			return "alert";
		} else {
			model.addAttribute("msg", "피드수정에 실패하였습니다.");
			model.addAttribute("url", "group_content.do?grp_no="+grp_no);
			return "alert";
		}
	}
	
	
	@RequestMapping(value="writeFeedOnBoard.do", method=RequestMethod.POST)
	public String writeFeedOnBoard(
			@RequestParam(value="file") MultipartFile uploadFile,
			@RequestParam(value="textarea_content") String content,
			@RequestParam(value="modal_grp_no") int grp_no,
			HttpSession session, Model model) throws Exception {
		Sports_Brd vo;
		int ret;
		String S3ImgUrl;
		String dir = "board/feed/";
		String id = (String) session.getAttribute("SID");
		if ( !(uploadFile.isEmpty()) ) {
			
			dir += grp_no;
			System.out.println(dir);
			System.out.println(uploadFile);
			System.out.println(content);
			System.out.println(session);
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			String date = sdf.format(new Date());
			System.out.println(date);
			String originName = uploadFile.getOriginalFilename();
			String extension = originName.substring(originName.indexOf("."));
			String keyName = dir+"/"+id+"/"+id+"_"+date+extension; 
			// S3 는 하위 디렉토리 개념이 아니라 /를 통한 key들을 읽음
			// 그래서 /를 붙이면 s3 console 에서 볼때 folder가 만들어짐
			// 폴더가 실제 트리구조의 하위 디렉토리가 아니라 key 값으로 읽음
	
			s3DAO.uploadFile(uploadFile, keyName);
			S3ImgUrl = amazonUrl+bucketName+"/"+keyName;
			System.out.println(S3ImgUrl);
			
		} else {
			//이미지를 첨부 하지 않았을때
			S3ImgUrl = null;
		}

		vo = new Sports_Brd(content, id, grp_no, S3ImgUrl);
		ret = bDAO.insertBoardOne(vo);
		
		if (ret == 1) {
			model.addAttribute("msg", "피드를 작성하였습니다.");
			model.addAttribute("url", "group_content.do?grp_no="+grp_no);
			return "alert";
		} else {
			model.addAttribute("msg", "피드작성에 실패하였습니다.");
			model.addAttribute("url", "group_content.do?grp_no="+grp_no);
			return "alert";
		}
	}
}
