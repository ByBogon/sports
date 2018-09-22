package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface CenterDAO {
	
	@Select({"SELECT ", 
		"	e.rnum, e.CENTER_AREA_NAME, e.CENTER_NAME, e.CENTER_ADDR, e.CENTER_TEL ", 
		"FROM ", 
		"	(SELECT ", 
		"		ROWNUM as rnum, d.CENTER_AREA_NAME, d.CENTER_NAME, d.CENTER_ADDR, d.CENTER_TEL ", 
		"	FROM ", 
		"		(SELECT ", 
		"			a.CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR, CENTER_TEL ", 
		"		FROM SPORTS_CENTER c ", 
		"		JOIN SPORTS_CENTER_AREA a ON c.CENTER_AREA_NO = a.CENTER_AREA_NO ", 
		"		WHERE CENTER_ADDR NOT LIKE '%'||#{addr}||'%' ", 
		"		ORDER BY CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR ASC) d ", 
		"	WHERE rownum <= #{end} ) e ", 
		"WHERE e.rnum >= #{start}"})
public List<Map<String, Object>> searchCenterWOMine(
		@Param("addr") String addr,
		@Param("start") int start,
		@Param("end") int end);
	
	@Select({"SELECT CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_TEL, ",
			" CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER"})
	public List<Map<String, Object>> selectCenterLocations();
	
	@Select({"SELECT NVL(COUNT(*), 0) ", 
			" FROM SPORTS_CENTER c ", 
			" JOIN SPORTS_CENTER_AREA a ON c.CENTER_AREA_NO = a.CENTER_AREA_NO ", 
			" WHERE CENTER_ADDR LIKE '%'||#{addr}||'%' OR CENTER_NAME LIKE '%'||#{addr}||'%'"
	})
	public int searchCenterCNT(@Param("addr") String addr);
	
	
	@Select({"SELECT ", 
			"	e.rnum, e.CENTER_AREA_NAME, e.CENTER_NAME, e.CENTER_ADDR, e.CENTER_TEL ", 
			"FROM ", 
			"	(SELECT ", 
			"		ROWNUM as rnum, d.CENTER_AREA_NAME, d.CENTER_NAME, d.CENTER_ADDR, d.CENTER_TEL ", 
			"	FROM ", 
			"		(SELECT ", 
			"			a.CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR, CENTER_TEL ", 
			"		FROM SPORTS_CENTER c ", 
			"		JOIN SPORTS_CENTER_AREA a ON c.CENTER_AREA_NO = a.CENTER_AREA_NO ", 
			"		WHERE CENTER_ADDR LIKE '%'||#{addr}||'%' OR CENTER_NAME LIKE '%'||#{addr}||'%' ", 
			"		ORDER BY CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR ASC) d ", 
			"	WHERE rownum <= #{end} ) e ", 
			"WHERE e.rnum >= #{start}"})
	public List<Map<String, Object>> searchCenter(
			@Param("addr") String addr,
			@Param("start") int start,
			@Param("end") int end);
	
	@Select({"SELECT CENTER_NAME, CENTER_ADDR, CENTER_TEL, CENTER_LAT, CENTER_LNG ",
			"FROM SPORTS_CENTER WHERE CENTER_ADDR LIKE '%'||#{addr}||'%'"})
	public Map<String, Object> selectCenterOne(@Param("addr") String addr);
	
}
