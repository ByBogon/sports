package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.mapping.StatementType;

public interface CenterDAO {
	
	@Select({"SELECT CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_TEL, ",
			" CENTER_LAT, CENTER_LNG FROM SPORTS_CENTER"})
	public List<Map<String, Object>> selectCenterLocations();

	@Options(statementType=StatementType.CALLABLE)
	@Select({"{ CALL PROC_SEARCH_CENTER (",
			" #{addr, mode=IN, jdbcType=VARCHAR, javaType=String}, ",
			" #{lat, mode=OUT, jdbcType=FLOAT, typeHandler=com.bybogon.sports.handler.OracleCallBackHandler}, ",
			" #{lng, mode=OUT, jdbcType=FLOAT, typeHandler=com.bybogon.sports.handler.OracleCallBackHandler} )}"})
	public List<Map<String, Float[]>> searchCenter(@Param("addr") String addr);
	
}
