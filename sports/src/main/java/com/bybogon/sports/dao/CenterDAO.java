package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

public interface CenterDAO {
	
	@Select({"SELECT CENTER_NO, ",
			" CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER WHERE SPORTS_NO = 0 ORDER BY CENTER_NO ASC"})
	public List<Map<String, Object>> selectCenterLocations();

}
