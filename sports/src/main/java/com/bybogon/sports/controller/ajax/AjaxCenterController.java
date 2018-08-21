package com.bybogon.sports.controller.ajax;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.CenterDAO;

@RestController
//mybatis-context 에서 scan package 추가 하면 mapperscan 필요 없음 
//mapperscan 는 interface 만으로 이루어진 dao를 읽어주기 위함. 
//@MapperScan({"com.ds.sts1.dao1"})
public class AjaxCenterController {
	@Autowired
	private CenterDAO cDAO;
	
	@RequestMapping(value = "/ajax_center_locations.do",
			method= {RequestMethod.GET, RequestMethod.POST},
			produces="application/json")
	public @ResponseBody List<Map<String, Object>> selectLocations() {
		List<Map<String, Object>> list = cDAO.selectCenterLocations();
		System.out.println(list);
		System.out.println(list.size());
		return list;
		
	}
	

}
