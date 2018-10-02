package com.bybogon.sports;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bybogon.sports.exception.PageNotFoundException;


@Controller
public class HomeController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "redirect:sports.do";
	}
	
	@RequestMapping(value = "alert.do", method = RequestMethod.GET)
	public String alert(
			@RequestParam(value="msg") String msg,
			@RequestParam(value="url") String url,
			HttpServletRequest request) {
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	
	//RequestMapping /{page이름 아무거나} - else 처리.
	@RequestMapping(value = "/{page}", method = RequestMethod.GET)
	public String page(@PathVariable("page") String page) {
		System.out.println(page);
		if (page.equals("home")) {
			return "redirect:sports.do";
		} else {
			//오류 강제 발생시킴 - 오류 종류는 PageNotFoundException
			throw new PageNotFoundException();
		}
	}
	//PageNotFoundException에 대한 처리를 여기서 담당.
	@ExceptionHandler(PageNotFoundException.class)
	public String pageNotFound() {
		return "page404";
	}
}
