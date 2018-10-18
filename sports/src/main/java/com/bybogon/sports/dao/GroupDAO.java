package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.bybogon.sports.vo.Sports_Grp;
import com.bybogon.sports.vo.Sports_Member;

public interface GroupDAO {

	@Select({"SELECT ", 
			"    MEM_NAME, b.GRP_NO, b.GRP_NAME, TO_CHAR(b.GRP_DATE, 'YYYYMMDD') grp_date, ", 
			"    b.memCnt AS cnt, b.GRP_MAINIMG, b.GRP_LEADER, b.SPORTS_NAME, b.CENTER_NO, ", 
			"    scm.CENTER_NAME, scm.CENTER_ADDR ",
			" FROM ",
			"    (SELECT ", 
			"        g.GRP_NO, g.GRP_NAME, g.GRP_DATE, g.GRP_MAINIMG, grpMem.memCnt, ", 
			"        g.GRP_LEADER, s.SPORTS_NAME, grp.CENTER_NO ", 
			"    FROM ", 
			"        (SELECT ", 
			"            cnt, GRP_NO, GRP_NAME, GRP_DATE, ", 
			"            GRP_MAINIMG, GRP_LEADER, CENTER_NO ", 
			"        FROM ",
			"            (WITH grp_brd as ( ", 
			"                (SELECT ", 
			"                        cnt, GRP_NO, GRP_NAME, GRP_DATE, ", 
			"                        GRP_MAINIMG, GRP_LEADER, CENTER_NO ", 
			"                    FROM ",
			"                        (SELECT ", 
			"                            (SELECT ", 
			"                                NVL(MAX(COUNT(DISTINCT BRD_NO)), 0) cnt ", 
			"                            FROM SPORTS_BRD brd ", 
			"                            WHERE brd.BRD_GROUP = grp.GRP_NO AND BRD_CHECK = 1 ", 
			"                            GROUP BY brd.BRD_GROUP ", 
			"                            ) cnt, ", 
			"                            GRP_NO, GRP_NAME, GRP_DATE, ", 
			"                            GRP_MAINIMG, GRP_LEADER, CENTER_NO ", 
			"                        FROM SPORTS_GRP grp ", 
			"                        ORDER BY cnt DESC ",
			"						 ) ",  
			"                    WHERE cnt > 0 ", 
			"                    ) ", 
			"                UNION ",
			"                    (SELECT ", 
			"                        cnt,GRP_NO, GRP_NAME, GRP_DATE, ", 
			"                        GRP_MAINIMG, GRP_LEADER, CENTER_NO ", 
			"                    FROM ",
			"                        (SELECT ", 
			"                            (SELECT ", 
			"                                NVL(MAX(COUNT(DISTINCT BRD_NO)), 0) cnt ", 
			"                            FROM SPORTS_BRD brd ",
			"                            WHERE brd.BRD_GROUP = grp.GRP_NO AND BRD_CHECK = 1 ", 
			"                            GROUP BY brd.BRD_GROUP ", 
			"                            ) cnt, ", 
			"                            GRP_NO, GRP_NAME, GRP_DATE, ", 
			"                            GRP_MAINIMG, GRP_LEADER, CENTER_NO ", 
			"                        FROM SPORTS_GRP grp ", 
			"                        ORDER BY grp_date ASC ",
			"						 ) ", 
			"                    WHERE cnt = 0 ", 
			"                    ) ", 
			"                ) ", 
			"                SELECT ", 
			"                    cnt, GRP_NO, GRP_NAME, GRP_DATE, ", 
			"                    GRP_MAINIMG, GRP_LEADER, CENTER_NO ", 
			"                FROM grp_brd ORDER BY cnt DESC ", 
			"                ) ",
			"        WHERE ROWNUM <= 3 ", 
			"        ) grp ", 
			"    INNER JOIN SPORTS_GRP g ON g.GRP_NO = grp.GRP_NO ",
			"	 JOIN ", 
			"        (SELECT ", 
			"			GRP_NO, NVL(COUNT(GRP_NO),0) memCnt ", 
			"        FROM SPORTS_GRP_MEM ", 
			"        GROUP BY GRP_NO ", 
			"        ) grpMem ON grpMEM.GRP_NO = g.GRP_NO ",
			"    JOIN SPORTS s ON g.SPORTS_NO = s.SPORTS_NO ",
			" ) b ", 
			" INNER JOIN SPORTS_MEMBER m ON m.MEM_ID = b.GRP_LEADER ", 
			" INNER JOIN SPORTS_CENTER_MASTER scm ON scm.CENTER_NO = b.CENTER_NO " 
	})
	public List<Sports_Grp> selectThreeBestGrp();
	
	@Select({"SELECT ", 
			"    MEM_NAME, b.GRP_NO, b.GRP_NAME, TO_CHAR(b.grp_date, 'YYYYMMDD') grp_date, ", 
			"    b.memCnt AS cnt, b.GRP_MAINIMG, b.GRP_LEADER, b.GRP_DETAIL, b.SPORTS_NAME, ",
			"	 scm.CENTER_NAME, scm.CENTER_ADDR ",
			"FROM ",
			"	(SELECT ", 
			"    	g.GRP_NO, g.GRP_NAME, g.GRP_DATE, grpMem.memCnt, ", 
			"   	g.GRP_MAINIMG, g.GRP_LEADER, g.GRP_DETAIL, s.SPORTS_NAME, grp.CENTER_NO ",
			"	FROM ",
			"		(SELECT ",
			"			* ",
			"		FROM ",
			"			(SELECT ", 
			"                GRP_NO, GRP_NAME, GRP_DATE, ", 
			"                GRP_MAINIMG, GRP_LEADER, GRP_DETAIL, CENTER_NO ", 
			"            FROM SPORTS_GRP ", 
			"            ORDER BY GRP_NO DESC) ", 
			"        WHERE ROWNUM <= 3 ",
			" 		) grp ", 
			"	INNER JOIN SPORTS_GRP g ON g.GRP_NO = grp.GRP_NO ",
			"	 JOIN ", 
			"        (SELECT ", 
			"			GRP_NO, NVL(COUNT(GRP_NO),0) memCnt ", 
			"        FROM SPORTS_GRP_MEM ", 
			"        GROUP BY GRP_NO ",
			"        ORDER BY GRP_NO DESC ",	
			"        ) grpMem ON grpMEM.GRP_NO = g.GRP_NO ",
			"	JOIN SPORTS s ON g.SPORTS_NO = s.SPORTS_NO) b ",
			"INNER JOIN SPORTS_MEMBER m ON m.MEM_ID = b.GRP_LEADER ",
			"INNER JOIN SPORTS_CENTER_MASTER scm ON scm.CENTER_NO = b.CENTER_NO"
		})
	public List<Sports_Grp> selectThreeNewGrp();
	
	@Options(useGeneratedKeys=false)
	@Update({"UPDATE SPORTS_GRP SET ",
			" 	GRP_NAME = #{vo.grp_name}, ",
			"	GRP_MAINIMG = #{vo.grp_mainimg} ",
			" WHERE GRP_NO = #{vo.grp_no}"
	})
	public int updateGroupOne(@Param("vo") Sports_Grp vo);
	
	@Options(useGeneratedKeys=false)
	@Update({"UPDATE SPORTS_GRP_MEM SET ", 
			"	GRP_MEM_CHECK = 0 ", 
			" WHERE GRP_MEM = #{cur_id} AND GRP_NO = #{grp_no} ", 
	})
	public int resignGrpMem(
			@Param("grp_no") int grp_no, 
			@Param("cur_id") String cur_id);
	
	@Options(useGeneratedKeys=false)
	@Insert({"MERGE INTO SPORTS_GRP_MEM ", 
		"    USING DUAL ", 
		"    ON ( GRP_MEM = #{extra_id} AND GRP_NO = #{grp_no} ) ", 
		"    WHEN MATCHED THEN ",
		"        UPDATE SET ", 
		"            GRP_MEM_CHECK = 1 ", 
		"        WHERE GRP_MEM = #{extra_id} AND GRP_NO = #{grp_no} ", 
		"    WHEN NOT MATCHED THEN ", 
		"        INSERT (GRP_MEM_NO, GRP_MEM, GRP_NO, GRP_MEM_CHECK, GRP_MEM_DATE) ", 
		"        VALUES (#{grp_mem_no}, #{extra_id}, #{grp_no}, 1, SYSDATE)" 
	})
	public int addExtraGrpMem(
			@Param("grp_mem_no") int grp_mem_no,
			@Param("grp_no") int grp_no, 
			@Param("extra_id") String extra_id);
	
	
	@Select({"SELECT ", 
			"    GRP_MEM, mems.MEM_NAME, mems.MEM_AGE, mems.MEM_IMG, mems.MEM_DETAIL, ", 
			"    mems.CENTER_NAME, mems.CENTER_NO, a.CENTER_AREA_NAME ",
			"FROM " + 
			"    (SELECT ", 
			"        gmem.GRP_MEM, gmem.MEM_NAME, gmem.MEM_AGE, gmem.CENTER_NO, gmem.MEM_IMG, ", 
			"        gmem.MEM_DETAIL, c.CENTER_NAME, c.CENTER_AREA_NO ",
			"    FROM ", 
			"        (SELECT GRP_MEM, MEM_NAME, MEM_AGE, CENTER_NO, MEM_IMG, MEM_DETAIL FROM ", 
			"            (WITH mems_info as ( ", 
			"                (SELECT GRP_MEM as grp_mem, ROWNUM as num FROM SPORTS_GRP_MEM m ", 
			"                INNER JOIN SPORTS_GRP g ", 
			"                ON g.GRP_NO = m.GRP_NO ", 
			"                WHERE m.GRP_NO = #{grp_no} AND GRP_MEM = GRP_LEADER ", 
			"                ) ", 
			"                UNION ", 
			"                (SELECT GRP_MEM as grp_mem, ROWNUM as num FROM SPORTS_GRP_MEM m1 ", 
			"                INNER JOIN SPORTS_GRP g1 ",
			"                ON g1.GRP_NO = m1.GRP_NO ", 
			"                WHERE m1.GRP_NO = #{grp_no} AND GRP_MEM != GRP_LEADER AND GRP_MEM_CHECK = 1 ", 
			"                ) ", 
			"            )", 
			"            SELECT grp_mem FROM mems_info order by num ",
			"            ) grp ", 
			"        INNER JOIN SPORTS_MEMBER mem ON mem.MEM_ID = grp.GRP_MEM ", 
			"        ) gmem ",
			"    LEFT JOIN SPORTS_CENTER c ON c.CENTER_NO = gmem.CENTER_NO ", 
			"    ) mems ", 
			"LEFT JOIN SPORTS_CENTER_AREA a ON a.CENTER_AREA_NO = mems.CENTER_AREA_NO " 
	})
	public List<Map<String, Object>> selectMemsOfGroup(
			@Param("grp_no") int grp_no);
	
	@Select({"SELECT ", 
			"	MEM_NAME, b.GRP_NO, b.GRP_NAME, b.grp_date, b.GRP_DETAIL, ", 
			"	b.GRP_MAINIMG, b.GRP_LEADER, b.cnt, b.SPORTS_NAME, ",
			"	scm.CENTER_NAME, scm.CENTER_ADDR, scm.CENTER_LAT, scm.CENTER_LNG ",
			" FROM ",
			"	(SELECT ", 
			"    	g.GRP_NO, g.CENTER_NO, g.GRP_NAME, TO_CHAR(g.GRP_DATE, 'YYYYMMDD') grp_date, ", 
			"   	g.GRP_DETAIL, g.GRP_MAINIMG, g.GRP_LEADER, grp.cnt, s.SPORTS_NAME ",
			"	FROM ", 
			"		(SELECT ", 
			"			GRP_NO, NVL(COUNT(GRP_NO),0) cnt ", 
			"		FROM SPORTS_GRP_MEM ", 
			"		WHERE GRP_NO = #{grp_no} ", 
			"		GROUP BY GRP_NO) grp ", 
			"	INNER JOIN SPORTS_GRP g ON g.GRP_NO = grp.GRP_NO ",
			"	JOIN SPORTS s ON g.SPORTS_NO = s.SPORTS_NO) b ",
			" INNER JOIN SPORTS_CENTER_MASTER scm ON scm.CENTER_NO = b.CENTER_NO ",
			" INNER JOIN SPORTS_MEMBER m ON m.MEM_ID = b.GRP_LEADER" 
	})
	public Sports_Grp selectGroupOne(@Param("grp_no") int grp_no);
	
	@Select({"<script>",
			"SELECT * FROM SPORTS_MEMBER ",
			" WHERE MEM_ID NOT IN ",
			" <foreach collection='idList' item='item' index='index' separator=',' open='(' close=')'> ",
			" #{item} ",
			" </foreach>",
			" AND SPORTS_NO = #{no}",
			"</script>"
			})
	public List<Sports_Member> showAddableMemberList(
			@Param("no") int no, 
			@Param("idList") List<String> idList);
	
	@Select({"SELECT * FROM SPORTS_MEMBER ",
			" WHERE MEM_ID NOT IN #{mem_id} AND SPORTS_NO = #{no}"})
	public List<Sports_Member> showAllMemberList(
		@Param("no") int no, 
		@Param("mem_id") String mem_id);
	
	@Select({"SELECT NVL(MAX(GRP_MEM_NO), 0) FROM SPORTS_GRP_MEM"})
	public int selectRecentGrpMemNo();
	
	@Select({"SELECT * FROM ( ",
			 "	SELECT GRP_NO FROM SPORTS_GRP ORDER BY GRP_DATE DESC ",
			 "	) ",
			 "WHERE ROWNUM = 1"})
	public int selectRecentGrpNo();
	

	@SelectKey(before=false, keyProperty = "vo.grp_no", resultType = int.class, 
			statement = { "SELECT * FROM ( ", 
							" SELECT GRP_NO FROM SPORTS_GRP ORDER BY GRP_NO DESC ", 
						"  ) ", 
						" WHERE ROWNUM = 1"})
	@Insert({"INSERT INTO SPORTS_GRP ",
			" 	(GRP_NO, GRP_NAME, GRP_DATE, GRP_CHK, SPORTS_NO, ",
			" 	GRP_CENTER, GRP_LEADER, CENTER_NO, GRP_DETAIL) ",			
			" VALUES ",
			" 	(SEQ_SPORTS_GRP_NO.NEXTVAL, #{vo.grp_name}, SYSDATE, 1, 0, ",
			" 	#{vo.grp_center}, #{vo.grp_leader}, #{vo.center_no}, #{vo.grp_detail})"})
	public int makeOneGrp(@Param("vo") Sports_Grp vo);
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_GRP_MEM(GRP_MEM_NO, GRP_MEM, GRP_NO) ",
			 "VALUES( #{no}, #{mem}, #{grp_no})"})
	public int makeGrpMemsForLeader(
			@Param("mem") String mem,
			@Param("no") int no, 
			@Param("grp_no") int grp_no);
	
	@Insert({"INSERT INTO SPORTS_GRP_LEADER(GRP_LEADER_NO, GRP_MEM_NO) ",
			" VALUES(SEQ_SPORTS_GRP_LEADER_NO.NEXTVAL, #{grp_mem_no})"
	})
	@Options(useGeneratedKeys=false)
	public int insertGrpLeader(@Param("grp_mem_no") int grpLeaderMemNo);
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_GRP_MEM(GRP_MEM_NO, GRP_MEM, GRP_NO) ",
			 "VALUES( #{no}, #{mem}, #{sportsGrpNo})"})
	public int makeGrpMems(@Param("mem") String mem, @Param("no") int no, 
			@Param("sportsGrpNo") int grp_no);
	
	@Select({"SELECT ",
			"	g.GRP_NO, TO_CHAR(g.GRP_DATE, 'YYYYMMDD') grp_date, GRP_NAME, ",
			"	GRP_DETAIL, grp.cnt, g.GRP_LEADER, s.SPORTS_NAME, ",
			"	scm.CENTER_NAME, scm.CENTER_ADDR, scm.CENTER_LAT, scm.CENTER_LNG ",
			" FROM ", 
			"    (SELECT ", 
			"        GRP_NO, NVL(COUNT(GRP_NO),0) cnt ", 
			"    FROM SPORTS_GRP_MEM ", 
			"    GROUP BY GRP_NO) grp ", 
			" INNER JOIN SPORTS_GRP g on g.GRP_NO = grp.GRP_NO ", 
			" JOIN ( ", 
			"    SELECT DISTINCT g.GRP_NO FROM SPORTS_GRP g ", 
			"    INNER JOIN SPORTS_GRP_MEM m ON g.GRP_NO = m.GRP_NO ", 
			"    WHERE GRP_MEM_CHECK = 1 AND (GRP_LEADER = #{id} OR GRP_MEM = #{id}) ", 
			"    ) grpno ON grpno.GRP_NO = g.GRP_NO ", 
			" INNER JOIN SPORTS_CENTER_MASTER scm ON scm.CENTER_NO = g.CENTER_NO ",
			" JOIN SPORTS s ON g.SPORTS_NO = s.SPORTS_NO ORDER BY GRP_DATE DESC"})
	public List<Sports_Grp> selectMyGroups(@Param("id") String id);
	
	@Select({"SELECT ",
			"	g.GRP_NO, GRP_DETAIL, GRP_NAME, TO_CHAR(g.GRP_DATE, 'YYYYMMDD') grp_date, ",
			"	s.SPORTS_NAME, g.GRP_LEADER, grp.cnt, ",
			"	scm.CENTER_NAME, scm.CENTER_ADDR, scm.CENTER_LAT, scm.CENTER_LNG ",
			"FROM ",
			"	(SELECT " , 
			"		GRP_NO, NVL(COUNT(GRP_NO),0) cnt ", 
			"	FROM SPORTS_GRP_MEM ",
			"	WHERE GRP_MEM_CHECK = 1 ", 
			"	GROUP BY GRP_NO) grp ",
			" INNER JOIN SPORTS_GRP g on g.GRP_NO = grp.GRP_NO ",
			" LEFT JOIN SPORTS_CENTER_MASTER scm ON scm.CENTER_NO = g.CENTER_NO",
			" JOIN SPORTS s ON g.SPORTS_NO = s.SPORTS_NO ORDER BY GRP_DATE DESC"})
	public List<Sports_Grp> selectAllGroups();

}
