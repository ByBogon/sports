package com.bybogon.sports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SportsController {
	
	@RequestMapping(value="sports.do", method=RequestMethod.GET)
	public String sportsMain(
			@RequestParam(value="sports", defaultValue="squash") String sports) {
		if (sports.equals("squash")) {
			
		} else if (sports.equals("basketball")) {
			
		} else if (sports.equals("tennis")) {
			
		}
		return "sports";
	}
}
