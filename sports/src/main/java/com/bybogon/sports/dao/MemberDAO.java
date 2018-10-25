package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.type.JdbcType;

import com.bybogon.sports.vo.Sports_Member;

public interface MemberDAO {
	
	@Select({"<script>",
			" SELECT * FROM SPORTS_MEMBER ",
			" WHERE ",
			" <if test=\"idList.size > 0\">",
			" MEM_ID NOT IN ",
			" <foreach collection='idList' item='item' index='index' separator=',' open='(' close=') AND '> ",
			" #{item} ",
			" </foreach>",
			" </if> ",
			" ( (MEM_ID != #{myid} AND MEM_ID LIKE #{mem}||'%') ",
			" OR (MEM_NAME != #{myname} AND MEM_NAME LIKE #{mem}||'%') ) ",
			"</script>"
	})
	public List<Sports_Member> searchAddableMemberList(
			@Param("mem") String mem,
			@Param("myid") String myid,
			@Param("myname") String myname,
			@Param("idList") List<String> idList);
	
	@Select({"<script>",
			"SELECT * FROM SPORTS_MEMBER ",
			" WHERE MEM_ID NOT IN ",
			" <foreach collection='idList' item='item' index='index' separator=',' open='(' close=')'> ",
			" #{item} ",
			" </foreach>",
			" AND SPORTS_NO = #{sportsGenreNo}",
			"</script>"
	})
	public List<Sports_Member> showAddableMemberList(
			@Param("sportsGenreNo") int sportsGenreNo, 
			@Param("idList") List<String> idList);
	
	@Select({"SELECT * FROM SPORTS_MEMBER ",
			" WHERE MEM_ID NOT IN #{mem_id} AND SPORTS_NO = #{sportsGenreNo}"})
	public List<Sports_Member> showAllMemberList(
		@Param("sportsGenreNo") int sportsGenreNo, 
		@Param("mem_id") String mem_id);
	
	
	@Options(useGeneratedKeys = false)
	@Update({"UPDATE SPORTS_MEMBER SET MEM_CHECK = 0 WHERE MEM_ID = #{id} AND MEM_PW = #{encPw}"})
	public int blockMember(@Param("id") String id, @Param("encPw") String pw);
	

	@Options(useGeneratedKeys = false)
	@Update({"UPDATE SPORTS_MEMBER ",
			" SET CENTER_NO = ",
			"	( SELECT CENTER_NO ", 
			"	  FROM SPORTS_CENTER ", 
			"	  WHERE CENTER_ADDR LIKE '%'||#{addr}||'%' ) ", 
			" WHERE MEM_ID = #{id}",
	})
	public int addMyCenter(@Param("id") String id, @Param("addr") String addr);
	
	@Select({"SELECT ", 
			"	c.CENTER_NAME, c.CENTER_ADDR, c.CENTER_AREA_NO, c.CENTER_TEL, ",
			"	c.CENTER_DETAIL, c.CENTER_LAT, c.CENTER_LNG, ", 
			"	m.CENTER_NO, m.MEM_NAME, m.MEM_IMG ", 
			"FROM SPORTS_MEMBER m LEFT JOIN SPORTS_CENTER c ON m.CENTER_NO = c.CENTER_NO ", 
			"WHERE MEM_ID = #{id}"
	})
	public Map<String, Object> selectMyCenterOne(@Param("id") String id);
	
	@Options(useGeneratedKeys=false)
	@Update({"<script> ",
			 " UPDATE SPORTS_MEMBER SET ",
			 " <if test=\"vo.mem_pw neq null\">",
			 "	MEM_PW = #{vo.mem_pw}, ",
			 " </if>",
			 "	MEM_NAME = #{vo.mem_name}, ",
			 "	MEM_AGE = #{vo.mem_age}, ",
			 "	MEM_EMAIL = #{vo.mem_email}, ",
			 "	MEM_DETAIL = #{vo.mem_detail} ",
			 "	, MEM_IMG = #{vo.mem_img} ",
			 " WHERE MEM_ID = #{vo.mem_id} AND MEM_CHECK = 1 ",
			 
	"</script>"})
	public int ajaxUpdateMemOne(@Param("vo") Sports_Member vo);
	
	@Select({"SELECT * FROM SPORTS_MEMBER WHERE MEM_ID = #{id} AND MEM_PW = #{pw}"})
	public Map<String, Object> ajaxPwCheck(@Param("id") String id, @Param("pw") String pw);

	@Select({"SELECT ",
			"    sm.MEM_ID, sm.MEM_AGE, sm.MEM_DETAIL, sm.MEM_IMG, sm.MEM_EMAIL, sm.MEM_NAME,", 
			"    NVL(COUNT(grpno.GRP_NO), 0) mcnt ", 
			"FROM (", 
			"    SELECT DISTINCT g.GRP_NO, GRP_LEADER FROM SPORTS_GRP g ", 
			"    INNER JOIN SPORTS_GRP_MEM m ON g.GRP_NO = m.GRP_NO ", 
			"    WHERE GRP_LEADER = #{id} OR GRP_MEM = #{id}", 
			"    ) grpno ", 
			"RIGHT JOIN SPORTS_MEMBER sm ON grpno.GRP_LEADER = sm.MEM_ID ", 
			"WHERE MEM_ID = #{id}", 
			"GROUP BY sm.MEM_ID, sm.MEM_AGE, sm.MEM_DETAIL, sm.MEM_IMG, sm.MEM_EMAIL, sm.MEM_NAME "})
	public Map<String, Object> ajaxSelectMemOne(@Param("id") String id);
	
	@Select({"SELECT NVL(COUNT(MEM_ID), 0) FROM SPORTS_MEMBER WHERE MEM_ID = #{id}"})
	public int ajaxIdCheck(@Param("id") String id);
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_MEMBER(MEM_ID, MEM_PW, MEM_NAME, MEM_AGE, MEM_EMAIL, MEM_CHECK, SPORTS_NO, LEVEL_NO,  MEM_DATE) ",
		" VALUES(#{mem_id}, #{mem_pw}, #{mem_name}, #{mem_age}, #{mem_email}, 1, 0, 1, SYSDATE)"})
	public int joinMember(Sports_Member vo);
	
	@Select({"SELECT * FROM SPORTS_MEMBER ",
			" WHERE MEM_ID = #{mem_id} AND MEM_PW = #{mem_pw} "})
	public Sports_Member loginMember(Sports_Member vo);
	
	@Select({"<script>",
			" SELECT ",
			"	MEM_ID, MEM_IMG, MEM_NAME, l.LEVEL_NAME ",
			" FROM SPORTS_MEMBER m ",
			" JOIN SPORTS_MEM_LEVEL l ON m.LEVEL_NO = l.LEVEL_NO ",
			" WHERE MEM_ID IN ",
			" <foreach collection='list' item='item' index='index' separator=',' open='(' close=')'> ",
			" #{item} ",
			" </foreach>",
			"</script>"})
	public List<Sports_Member> selectMemberList(@Param("list") String[] id_list);
}
