package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface CenterDAO {
	
	@Select({"SELECT CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_TEL, ",
			" CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER"})
	public List<Map<String, Object>> selectCenterLocations();

	@Select({"SELECT CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER ",
			" WHERE CENTER_ADDR LIKE '%'||#{addr}||'%'"})
	public List<Map<String, Object>> searchCenter(@Param("addr") String addr);
	
}
