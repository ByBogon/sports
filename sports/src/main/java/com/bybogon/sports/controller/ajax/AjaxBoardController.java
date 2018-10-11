package com.bybogon.sports.controller.ajax;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.BoardDAO;

@RestController
public class AjaxBoardController {
	String amazonUrl = "https://s3.ap-northeast-2.amazonaws.com/";
	
	@Autowired
	private BoardDAO bDAO;
	
	@Value("${aws_namecard_bucket}")
	private String bucketName;
	
	@RequestMapping(value = "writeCommentOnBoard.do", method = RequestMethod.GET)
	public int writeCommentOnBoard(
			@RequestParam(value="brd_no") int brd_no,
			@RequestParam(value="rpl_content") String rpl_content,
			@RequestParam(value="rpl_writer") String rpl_writer) {
		System.out.println(brd_no);
		System.out.println(rpl_content);
		System.out.println(rpl_writer);
		int ret = bDAO.insertCommentOnBoard(brd_no, rpl_content, rpl_writer);
		System.out.println(ret);
		return ret;
	}
	
}
