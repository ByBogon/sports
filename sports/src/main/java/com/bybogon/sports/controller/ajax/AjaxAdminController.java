package com.bybogon.sports.controller.ajax;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.AdminDAO;

@RestController
public class AjaxAdminController {
	
	@Autowired
	private AdminDAO aDAO;
	
	
	@RequestMapping(value = "ajaxAdminCenterTotalCnt.do", method = RequestMethod.GET)
	public List<Map<String, Object>> selectAdminCenterTotalCnt() {
		List<Map<String, Object>> list = aDAO.selectAdminCenterTotalCnt();
		
		return list;
	}
	
	@RequestMapping(value = "ajaxAdminCenterCntByArea.do", method = RequestMethod.GET)
	public Map<String, Object> selectAdminCenterCntByArea() {
		List<Map<String, Object>> list = aDAO.selectAdminCenterCntByArea();
		String[] areaName = new String[list.size()];
		int[] centerCnt = new int[list.size()];
		
		for(int i=0; i < list.size(); i++) {
			areaName[i] = (String) list.get(i).get("area_name");
			centerCnt[i] = (Integer) list.get(i).get("cnt");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("areaName", areaName);
		map.put("centerCnt", centerCnt);
		return map;
	}
	
	@RequestMapping(value = "ajaxAdminTotalCnt.do", method = RequestMethod.GET)
	public Map<String, Object> selectAdminTotalCnt() {
		Map<String, Object> map = aDAO.selectAdminAllContentCnt();
		return map;
	}
	
	@RequestMapping(value = "ajaxAdminCntDayByDay.do", method = RequestMethod.GET)
	public Map<String, Object> selectAdminMemCntByDay() {
		List<Map<String, Object>> list = aDAO.selectAdminNewMemCntByDay();
		List<Map<String, Object>> brdList = aDAO.selectAdminNewBrdCntByDay();
		List<Map<String, Object>> grpList = aDAO.selectAdminNewGrpCntByDay();
		int mlsize = list.size(), blsize = brdList.size(), glsize = grpList.size();
		
		String[] day = new String[mlsize+blsize+glsize];
		
		for (int i=0; i<mlsize; i++) {
			day[i] = (String) list.get(i).get("MEM_DATE");
		}
		for (int i=0; i<blsize; i++) {
			day[i+mlsize] = (String) brdList.get(i).get("BRD_DATE");
		}
		for (int i=0; i<glsize; i++) {
			day[i+mlsize+blsize] = (String) grpList.get(i).get("GRP_DATE");
		}
		
		if (day.length > 1) {
			Arrays.sort(day);
			Arrays.toString(day);
		}
		int tmp = 1;
		for (int i=1; i < day.length; i++) {
			if( !(day[i-1].equals(day[i])) ) {
				day[tmp++] = day[i];
			} 
		}
		
		String[] tmps = new String[tmp];
		for (int i=0; i<tmps.length; i++) {
			tmps[i] = day[i];
		}
		
		int[] memCnt = new int[tmps.length];
		int[] brdCnt = new int[tmps.length];
		int[] grpCnt = new int[tmps.length];
		int j = 0;
		
		for (int i=0; i<memCnt.length; i++) {
			if (j < list.size() ) {
				if(list.get(j).get("MEM_DATE").equals(tmps[i])) {
					memCnt[i] = (Integer) list.get(j).get("cnt");
					j++;
				} else {
					memCnt[i] = 0;
				}
			}
		}
		
		j = 0;
		for (int i=0; i<brdCnt.length; i++) {
			if (j < brdList.size() ) {
				if(brdList.get(j).get("BRD_DATE").equals(tmps[i])) {
					brdCnt[i] = (Integer) brdList.get(j).get("cnt");
					j++;
				} else {
					brdCnt[i] = 0;
				}
			}
		}
		
		j = 0;
		for (int i=0; i<grpCnt.length; i++) {
			if (j < grpList.size() ) {
				if(grpList.get(j).get("GRP_DATE").equals(tmps[i])) {
					grpCnt[i] = (Integer) grpList.get(j).get("cnt");
					j++;
				} else {
					grpCnt[i] = 0;
				}
			}
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memCnt", memCnt);
		map.put("brdCnt", brdCnt);
		map.put("grpCnt", grpCnt);
		map.put("day", tmps);
		return map;
	}

}
