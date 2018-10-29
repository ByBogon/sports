package com.bybogon.sports.controller.ajax;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bybogon.sports.dao.CenterDAO;
import com.bybogon.sports.vo.Sports_Infrm_Center;

@RestController
//mybatis-context 에서 scan package 추가 하면 mapperscan 필요 없음 
//mapperscan 는 interface 만으로 이루어진 dao를 읽어주기 위함. 
//@MapperScan({"com.ds.sts1.dao1"})
public class AjaxCenterController {
	int pageContentCNT = 10;
	
	@Autowired
	private CenterDAO cDAO;
	
	@Transactional
	@RequestMapping(value = "ajaxAdminCenterUpdate.do", method = RequestMethod.POST)
	public Sports_Infrm_Center ajaxAdminCenterUpdate(
			@RequestParam(value="center_no") int center_no,
			@RequestParam(value="center_name") String center_name,
			@RequestParam(value="center_addr") String center_addr,
			@RequestParam(value="center_tel") String center_tel,
			@RequestParam(value="center_detail") String center_detail,
			@RequestParam(value="center_updated_check") int center_updated_check			
			) {
		int ret;
		Sports_Infrm_Center vo = new Sports_Infrm_Center(
				center_no,
				center_name,
				center_addr,
				center_tel,
				center_detail,
				center_updated_check);
		
		ret = cDAO.updateCenterByAdmin(vo);
		ret += cDAO.updateMasterCenterByAdmin(vo);
		vo = cDAO.selectInformingCenterByAdmin(vo.getInfrm_center_no());
		if( (ret == 2) && (vo != null) ) {
			return vo;
		}
		return null;
	}
	
	@RequestMapping(value = "insertInformingCenter.do", method = RequestMethod.POST)
	public int insertNewCenter(
			@RequestParam(value="memId") String memId,
			@RequestParam(value="centerAddr") String centerAddr,
			@RequestParam(value="centerName") String centerName,
			@RequestParam(value="centerDetail") String centerDetail,
			@RequestParam(value="centerLat") float centerLat,
			@RequestParam(value="centerLng") float centerLng) {
		int ret = cDAO.insertInfrmCenterOneByMem(
				memId, 
				centerAddr,
				centerName,
				centerDetail,
				centerLat,
				centerLng);
		return ret;
	}
	
	@RequestMapping(value = "/ajax_center_locations.do",
			method= {RequestMethod.GET, RequestMethod.POST},
			produces="application/json")
	public @ResponseBody List<Map<String, Object>> selectLocations() {
		List<Map<String, Object>> list = cDAO.selectCenterLocations();
		return list;
	}
	
	@RequestMapping(value = "ajax_center_searchCNT.do",
			method = {RequestMethod.GET, RequestMethod.POST})
	public int searchCenterCNT(
			@RequestParam(value = "myCenterNo", required=false, defaultValue = "0") Integer myCenterNo,
			@RequestParam(value = "addr", required=false, defaultValue=" " ) String[] addrList) {
		int totalCnt = cDAO.searchCenterCNT(myCenterNo, addrList);
		int total_pageCnt = (totalCnt/pageContentCNT)+1;
		return total_pageCnt;
	}
	
	@RequestMapping(value = "ajax_center_search.do",
			method = {RequestMethod.GET, RequestMethod.POST},
			produces = "application/json")
	public @ResponseBody List<Map<String, Object>> searchCenter(
			@RequestParam(value = "addr") String[] addrList,
			@RequestParam(value = "page", defaultValue="1") int page) {
		int start = (page * pageContentCNT) - pageContentCNT + 1;
		int end = (page * pageContentCNT);
		List<Map<String, Object>> list = cDAO.searchCenter(addrList, start, end);
		return list;
	}
	@RequestMapping(value = "ajax_center_search_except_mine.do",
			method = {RequestMethod.GET, RequestMethod.POST},
			produces = "application/json")
	public @ResponseBody List<Map<String, Object>> searchCenterWOMine(
			@RequestParam(value = "myCenterNo", required=false) int myCenterNo,
			@RequestParam(value = "addr") String addr,
			@RequestParam(value = "page", defaultValue="1") int page) {
		int start = (page * pageContentCNT) - pageContentCNT + 1;
		int end = (page * pageContentCNT);
		List<Map<String, Object>> list = cDAO.searchCenterWOMine(myCenterNo, addr, start, end);
		return list;
	}
	
	@RequestMapping(value =" ajax_center_one.do",
			method = {RequestMethod.GET, RequestMethod.POST},
			produces="application/json")
	public @ResponseBody Map<String, Object> selectCenterOne(
			@RequestParam(value="addr") String addr) {
		Map<String, Object> map = cDAO.selectCenterOne(addr);
		return map;
	}
	
}
