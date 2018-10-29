package com.bybogon.sports.controller.ajax;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.BoardDAO;

@RestController
public class AjaxBoardController {
	@Autowired
	private BoardDAO bDAO;
	
	
	@RequestMapping(value = "ajaxDelBoard.do", method = RequestMethod.GET)
	public int deleteOneBoard(@RequestParam(value="brd_no") int brd_no) {
		int ret = bDAO.deleteOneBoard(brd_no);
		return ret;
	}
	
	@RequestMapping(value = "ajaxUpdateComment.do", method = RequestMethod.GET)
	public int updateCommentOnBoard(
			@RequestParam(value="rpl_no") int rpl_no,
			@RequestParam(value="rpl_content") String rpl_content) {
		int ret = bDAO.updateCommentOnBoard(rpl_no, rpl_content);
		
		return ret;
	}
	
	@RequestMapping(value = "ajaxDeleteComment.do", method = RequestMethod.GET)
	public int deleteCommentOnBoard(
			@RequestParam(value="rpl_no") int rpl_no) {
		int ret = bDAO.deleteCommentOnBoard(rpl_no);
		return ret;
	}
	
	@RequestMapping(value = "ajaxCommentsList.do", method = RequestMethod.GET)
	public List<Map<String, Object>> selectCommentsListOnBoard(
			@RequestParam(value="brd_no") int brd_no) {
		List<Map<String, Object>> list = bDAO.selectCommentsListOnBoard(brd_no);
		return list;
	}
	
	@RequestMapping(value = "writeCommentOnBoard.do", method = RequestMethod.GET)
	public int writeCommentOnBoard(
			@RequestParam(value="brd_no") int brd_no,
			@RequestParam(value="rpl_content") String rpl_content,
			@RequestParam(value="rpl_writer") String rpl_writer) {
		int ret = bDAO.insertCommentOnBoard(brd_no, rpl_content, rpl_writer);
		return ret;
	}
	
}
