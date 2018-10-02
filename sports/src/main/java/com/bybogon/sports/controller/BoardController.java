package com.bybogon.sports.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bybogon.sports.dao.impl.AwsS3DAOImpl;

@Controller
public class BoardController {
	@Autowired
	private AwsS3DAOImpl s3DAO;
	
	@Value("${aws_namecard_bucket}")
	private String bucketName;
	
	@RequestMapping(value="writeFeedOnBoard.do", method=RequestMethod.POST)
	public String writeFeedOnBoard(
			@RequestParam(value="file") MultipartFile uploadFile,
			@RequestParam(value="textarea_content") String content,
			@RequestParam(value="grp_no") int grp_no,
			HttpSession session) throws Exception{
		String dir = "/board/feed"+grp_no;
		System.out.println(dir);
		System.out.println(uploadFile);
		System.out.println(content);
		System.out.println(session);
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String date = sdf.format(new Date());
		System.out.println(date);
		String id = (String) session.getAttribute("SID");
		String originName = uploadFile.getOriginalFilename();
		String extension = originName.substring(originName.indexOf("."));
		String keyName = id+"/"+id+"_"+date+extension; 
		// S3 는 하위 디렉토리 개념이 아니라 /를 통한 key들을 읽음
		// 그래서 /를 붙이면 s3 console 에서 볼때 folder가 만들어짐
		// 폴더가 실제 트리구조의 하위 디렉토리가 아니라 key 값으로 읽음

		s3DAO.uploadFile(uploadFile, keyName);
		String S3ImgUrl = bucketName+dir+"/"+keyName;
		System.out.println(S3ImgUrl);
		
		return (String) session.getAttribute("BACK_URL");
	}
}
