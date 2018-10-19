package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.type.JdbcType;

import com.bybogon.sports.vo.Sports_Infrm_Center;

public interface CenterDAO {
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT ALL ",
		" 	INTO SPORTS_INFORMING_CENTER ",
		" 		(INFRM_CENTER_NO, INFRM_CENTER_NAME, INFRM_CENTER_ADDR, INFRM_CENTER_DETAIL, INFRM_CENTER_REG_CHECK, SPORTS_NO, ",
		" 	 	 INFRM_CENTER_REG_DATE, INFRM_CENTER_UPDATED_CHECK, INFRM_CENTER_LAT, INFRM_CENTER_LNG, MEM_ID) ",
		" VALUES ",
		" 		(SEQ_SPORTS_CENTER_NO.NEXTVAL, #{centerName}, #{centerAddr}, #{centerDetail}, 0, 0, ",
		"		 SYSDATE, 0, #{centerLat}, #{centerLng}, #{memId} ) ",
		" 	INTO SPORTS_CENTER_MASTER ",
		" 		(CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_DETAIL, CENTER_REG_CHECK, SPORTS_NO, CENTER_REG_DATE, ",
		"		 CENTER_UPDATED_CHECK, CENTER_LAT, CENTER_LNG, MEM_ID) ",
		" 	VALUES ",
		" 		(SEQ_SPORTS_CENTER_NO.NEXTVAL, #{centerName}, #{centerAddr}, #{centerDetail}, 0, 0, SYSDATE, ",
		"		 0, #{centerLat}, #{centerLng}, #{memId} ) ",
		" SELECT * FROM DUAL"})
	public int insertInfrmCenterOneByMem(
			@Param("memId") String memId, 
			@Param("centerAddr") String centerAddr,
			@Param("centerName") String centerName,
			@Param("centerDetail") String centerDetail,
			@Param("centerLat") float centerLat,
			@Param("centerLng") float centerLng);
	
	
	@SelectKey(before=false, keyProperty = "vo.infrm_center_no", resultType = int.class, 
			statement = { "SELECT * FROM ( ", 
							" SELECT INFRM_CENTER_NO FROM SPORTS_INFORMING_CENTER ORDER BY INFRM_CENTER_NO DESC ", 
						"  ) ", 
						" WHERE ROWNUM = 1"})
	@Insert({"INSERT ALL ",
			" 	INTO SPORTS_INFORMING_CENTER ",
			" 		(INFRM_CENTER_NO, INFRM_CENTER_NAME, INFRM_CENTER_ADDR, INFRM_CENTER_REG_CHECK, SPORTS_NO, ",
			" 	 	INFRM_CENTER_REG_DATE, INFRM_CENTER_UPDATED_CHECK, INFRM_CENTER_LAT, INFRM_CENTER_LNG) ",
			" VALUES ",
			" 		(SEQ_SPORTS_CENTER_NO.NEXTVAL, #{vo.infrm_center_name}, #{vo.infrm_center_addr}, 0, 0, SYSDATE, 0, #{vo.infrm_center_lat}, #{vo.infrm_center_lng}) ",
			" 	INTO SPORTS_CENTER_MASTER ",
			" 		(CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_REG_CHECK, SPORTS_NO, CENTER_REG_DATE, CENTER_UPDATED_CHECK, CENTER_LAT, CENTER_LNG) ",
			" 	VALUES ",
			" 		(SEQ_SPORTS_CENTER_NO.NEXTVAL, #{vo.infrm_center_name}, #{vo.infrm_center_addr}, 0, 0, SYSDATE, 0, #{vo.infrm_center_lat}, #{vo.infrm_center_lng}) ",
			" SELECT * FROM DUAL"
	})
	public int insertInfrmCenterOneByGrp(
			@Param("vo") Sports_Infrm_Center vo);
	
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
	
	@Select({"<script>",
			" SELECT NVL(COUNT(*), 0) ", 
			" FROM SPORTS_CENTER c ", 
			" JOIN SPORTS_CENTER_AREA a ON c.CENTER_AREA_NO = a.CENTER_AREA_NO ", 
			" WHERE ",
			" <foreach collection='addrList' item='addr' index='index' separator='AND' >",
			" (CENTER_ADDR LIKE '%'||#{addr}||'%' OR CENTER_NAME LIKE '%'||#{addr}||'%') ",
			" </foreach>",
			"</script>"
	})
	public int searchCenterCNT(@Param("addrList") String[] addrList);
	
	@Select({"<script>",
			" SELECT ", 
			"	e.rnum, e.CENTER_AREA_NAME, e.CENTER_NAME, e.CENTER_ADDR, e.CENTER_TEL ", 
			" FROM ", 
			"	(SELECT ", 
			"		ROWNUM as rnum, d.CENTER_AREA_NAME, d.CENTER_NAME, d.CENTER_ADDR, d.CENTER_TEL ", 
			"	FROM ", 
			"		(SELECT ", 
			"			a.CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR, CENTER_TEL ", 
			"		FROM SPORTS_CENTER c ", 
			"		JOIN SPORTS_CENTER_AREA a ON c.CENTER_AREA_NO = a.CENTER_AREA_NO ", 
			"		WHERE ",
			"		<foreach collection='addrList' item='addr' index='index' separator='AND' >",
			"			(CENTER_ADDR LIKE '%'||#{addr}||'%' OR CENTER_NAME LIKE '%'||#{addr}||'%') ",
			"		</foreach>", 
			"		ORDER BY CENTER_AREA_NAME, CENTER_NAME, CENTER_ADDR ASC) d ", 
			" <![CDATA[",
			"	WHERE rownum <= #{end} ) e ", 
			" WHERE e.rnum >= #{start}",
			" ]]>",
			" </script>"
	})
	public List<Map<String, Object>> searchCenter(
			@Param("addrList") String[] addrList,
			@Param("start") int start,
			@Param("end") int end);
	@Results({
		@Result(column="CENTER_NO", property="CENTER_NO", jdbcType=JdbcType.INTEGER, javaType=int.class),
		@Result(column="CENTER_NAME", property="CENTER_NAME", jdbcType=JdbcType.VARCHAR),
		@Result(column="CENTER_ADDR", property="CENTER_ADDR", jdbcType=JdbcType.VARCHAR),
		@Result(column="CENTER_TEL", property="CENTER_TEL", jdbcType=JdbcType.VARCHAR),
		@Result(column="CENTER_LAT", property="CENTER_LAT", jdbcType=JdbcType.FLOAT),
		@Result(column="CENTER_LNG", property="CENTER_LNG", jdbcType=JdbcType.FLOAT),
	})
	@Select({"SELECT CENTER_NO, CENTER_NAME, CENTER_ADDR, CENTER_TEL, CENTER_LAT, CENTER_LNG ",
			"FROM SPORTS_CENTER WHERE CENTER_ADDR LIKE '%'||#{addr}||'%'"})
	public Map<String, Object> selectCenterOne(@Param("addr") String addr);
	
}
