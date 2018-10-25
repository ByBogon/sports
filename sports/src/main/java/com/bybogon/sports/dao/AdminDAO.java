package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.type.JdbcType;

public interface AdminDAO {
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
	public List<Map<String, Object>> selectAdminBrdCntByDay();

	
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
	public List<Map<String, Object>> selectAdminMemCntByDay();


}
