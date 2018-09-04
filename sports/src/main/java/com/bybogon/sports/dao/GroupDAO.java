package com.bybogon.sports.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import com.bybogon.sports.vo.Sports_Grp;
import com.bybogon.sports.vo.Sports_Member;

public interface GroupDAO {
	
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
	
	@Select({"SELECT MAX(NVL(GRP_MEM_NO, 0)) FROM SPORTS_GRP_MEM"})
	public int selectRecentGrpMemNo();
	
	@Select({"SELECT GRP_NO FROM SPORTS_GRP WHERE GRP_NAME = #{grp_name}"})
	public int selectRecentSportsGrpNo(@Param("grp_name") String grp_name);
	
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_GRP (GRP_NO, GRP_NAME, GRP_DATE, GRP_CHK, SPORTS_NO, ",
			" GRP_CENTER, GRP_LEADER) ",			
			" VALUES (SEQ_SPORTS_GRP_NO.NEXTVAL, #{vo.grp_name}, SYSDATE, 1, 0, ",
				" #{vo.grp_center}, #{vo.grp_leader})"})
	public int makeOneGrp(@Param("vo") Sports_Grp vo);
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_GRP_MEM(GRP_MEM_NO, GRP_MEM, GRP_NO) ",
			 "VALUES( #{no}, #{mem}, #{sportsGrpNo})"})
	public int makeGrpMems(@Param("mem") String mem, @Param("no") int no, 
			@Param("sportsGrpNo") int grp_no);

	
	
	@Select({"SELECT TO_CHAR(g.GRP_DATE, 'YYYYMMDD') grp_date, GRP_NAME, ",
			"	grp.cnt, g.GRP_LEADER, s.SPORTS_NAME FROM ", 
			"    (SELECT ", 
			"        GRP_NO, NVL(COUNT(GRP_NO),0) cnt ", 
			"    FROM SPORTS_GRP_MEM ", 
			"    GROUP BY GRP_NO) grp ", 
			" INNER JOIN SPORTS_GRP g on g.GRP_NO = grp.GRP_NO ", 
			" JOIN ( ", 
			"    SELECT DISTINCT g.GRP_NO FROM SPORTS_GRP g ", 
			"    INNER JOIN SPORTS_GRP_MEM m ON g.GRP_NO = m.GRP_NO ", 
			"    WHERE GRP_LEADER = #{id} OR GRP_MEM = #{id} ", 
			"    ) grpno ON grpno.GRP_NO = g.GRP_NO ", 
			"JOIN SPORTS s ON g.SPORTS_NO = s.SPORTS_NO ORDER BY GRP_DATE DESC"})
	public List<Sports_Grp> selectMyGroups(@Param("id") String id);

}
