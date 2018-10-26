package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.type.JdbcType;

public interface AdminDAO {
	
	@Select({"SELECT * FROM (",
			"	SELECT center.*, ROWNUM as num FROM ", 
			"		(WITH center_cnt AS ( ", 
			"			SELECT * FROM ( ", 
			"        		SELECT COUNT(c.CENTER_NO) cnt, a.CENTER_AREA_NAME as area_name ", 
			"	        	FROM SPORTS_CENTER c ",
			"   	     	INNER JOIN SPORTS_CENTER_AREA a ON a.CENTER_AREA_NO = c.CENTER_AREA_NO ", 
			"       	 	GROUP BY a.CENTER_AREA_NAME ", 
			"        		ORDER BY COUNT(c.CENTER_NO) DESC ", 
			"        	) WHERE ROWNUM <= 2 ", 
			"        	UNION ", 
			"        	SELECT * FROM ( ",
			"        		SELECT COUNT(c.CENTER_NO) cnt, a.CENTER_AREA_NAME as area_name ", 
			"        		FROM SPORTS_CENTER c ",
			"        		INNER JOIN SPORTS_CENTER_AREA a ON a.CENTER_AREA_NO = c.CENTER_AREA_NO ", 
			"        		GROUP BY a.CENTER_AREA_NAME ", 
			"        		ORDER BY COUNT(c.CENTER_NO) ASC ", 
			"        	) WHERE ROWNUM = 1 ", 
			"    	) ",
			"    SELECT * FROM center_cnt ORDER BY ROWNUM DESC ", 
			"    ) center ",
			" ) "})
	public List<Map<String, Object>> selectAdminCenterTotalCnt();
	
	@Results({
		@Result(column="cnt", property="cnt", jdbcType=JdbcType.INTEGER, javaType=int.class),
		@Result(column="area_name", property="area_name", jdbcType=JdbcType.VARCHAR),
	})
	@Select({"SELECT COUNT(c.CENTER_NO) cnt, a.CENTER_AREA_NAME as area_name ", 
			" FROM SPORTS_CENTER c ", 
			" INNER JOIN SPORTS_CENTER_AREA a ON a.CENTER_AREA_NO = c.CENTER_AREA_NO ", 
			" GROUP BY a.CENTER_AREA_NAME ",
			" ORDER BY a.CENTER_AREA_NAME ASC"
	})
	public List<Map<String, Object>> selectAdminCenterCntByArea();
	
	@Select({"SELECT ", 
			"    (SELECT COUNT(MEM_ID) ", 
			"     FROM SPORTS_MEMBER ", 
			"     ) memCnt, ",
			"     (SELECT COUNT(BRD_NO) ", 
			"     FROM SPORTS_BRD ", 
			"     ) brdCnt, ", 
			"     (SELECT COUNT(GRP_NO) ", 
			"     FROM SPORTS_GRP ", 
			"     ) grpCnt ", 
			"FROM DUAL"
	})
	public Map<String, Object> selectAdminAllContentCnt();
	
	@Results({
		@Result(column="cnt", property="cnt", jdbcType=JdbcType.INTEGER, javaType=int.class),
		@Result(column="GRP_DATE2", property="GRP_DATE", jdbcType=JdbcType.VARCHAR),
	})
	@Select({"SELECT ",
			" 	COUNT(GRP_NO) cnt, TO_CHAR(GRP_DATE, 'YY-MM-DD') GRP_DATE2 ", 
			" FROM ",
			" 	SPORTS_GRP ", 
			" GROUP BY TO_CHAR(GRP_DATE, 'YY-MM-DD') ", 
			" ORDER BY TO_CHAR(GRP_DATE, 'YY-MM-DD') ASC"
	})
	public List<Map<String, Object>> selectAdminNewGrpCntByDay();
	
	@Results({
		@Result(column="cnt", property="cnt", jdbcType=JdbcType.INTEGER, javaType=int.class),
		@Result(column="BRD_DATE2", property="BRD_DATE", jdbcType=JdbcType.VARCHAR),
	})
	@Select({"SELECT ",
			" 	COUNT(BRD_NO) cnt, TO_CHAR(BRD_DATE, 'YY-MM-DD') BRD_DATE2 ", 
			" FROM ",
			" 	SPORTS_BRD ", 
			" GROUP BY TO_CHAR(BRD_DATE, 'YY-MM-DD') ", 
			" ORDER BY TO_CHAR(BRD_DATE, 'YY-MM-DD') ASC"
	})
	public List<Map<String, Object>> selectAdminNewBrdCntByDay();

	
	@Results({
		@Result(column="cnt", property="cnt", jdbcType=JdbcType.INTEGER, javaType=int.class),
		@Result(column="MEM_DATE2", property="MEM_DATE", jdbcType=JdbcType.VARCHAR),
	})
	@Select({"SELECT ",
			" 	COUNT(MEM_ID) cnt, TO_CHAR(MEM_DATE, 'YY-MM-DD') MEM_DATE2 ", 
			" FROM ",
			" 	SPORTS_MEMBER ", 
			" GROUP BY TO_CHAR(MEM_DATE, 'YY-MM-DD') ", 
			" ORDER BY TO_CHAR(MEM_DATE, 'YY-MM-DD') ASC"
	})
	public List<Map<String, Object>> selectAdminNewMemCntByDay();


}
