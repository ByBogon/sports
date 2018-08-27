package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface CenterDAO {
	
	@Select({"SELECT CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_TEL, ",
			" CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER"})
	public List<Map<String, Object>> selectCenterLocations();

	/*@Options(statementType=StatementType.CALLABLE)
	@Select({"{ CALL PROC_SEARCH_CENTER (",
			" #{addr, mode=IN, jdbcType=VARCHAR, javaType=String}, ",
			" #{lat, mode=OUT, jdbcType=NUMERIC, javaType=java.sql.ResultSet, typeHandler=com.bybogon.sports.handler.OracleCallBackHandler}, ",
			" #{lng, mode=OUT, jdbcType=NUMERIC, javaType=java.sql.ResultSet, typeHandler=com.bybogon.sports.handler.OracleCallBackHandler} )}"})
	@Results(value= {
			@Result(column="lat", property="FLOAT_ARRAY_TABLE", jdbcType=JdbcType.NUMERIC, 
					javaType=ArrayList.class, typeHandler=com.bybogon.sports.handler.OracleCallBackHandler.class),
			@Result(column="lng", property="FLOAT_ARRAY_TABLE", jdbcType=JdbcType.NUMERIC, 
					javaType=ArrayList.class, typeHandler=com.bybogon.sports.handler.OracleCallBackHandler.class)
	})
	public List<Map<String, Float[]>> searchCenter(@Param("addr") String addr);*/
	
	@Select({"SELECT CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR, CENTER_TEL FROM SPORTS_CENTER c ",
		" JOIN SPORTS_CENTER_AREA a ON c.CENTER_AREA_NO = a.CENTER_AREA_NO ",
		" WHERE CENTER_ADDR LIKE '%'||#{addr}||'%' OR CENTER_NAME LIKE '%'||#{addr}||'%' ORDER BY CENTER_AREA_NAME ASC"})
	public List<Map<String, Object>> searchCenter(@Param("addr") String addr);
	
	@Select({"SELECT CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER WHERE CENTER_ADDR LIKE '%'||#{addr}||'%'"})
	public Map<String, Object> selectCenterOne(@Param("addr") String addr);
	
}
