package com.bybogon.sports.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bybogon.sports.vo.Sports_Member;

public interface MemberDAO {
	
	@Select("SELECT NVL(COUNT(MEM_ID), 0) FROM SPORTS_MEMBER WHERE MEM_ID = #{id}")
	public int ajaxIdCheck(@Param("id") String id);
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_MEMBER(MEM_ID, MEM_PW, MEM_NAME, MEM_AGE, MEM_EMAIL, MEM_CHECK, SPORTS_NO, LEVEL_NO,  MEM_DATE) ",
		" VALUES(#{mem_id}, #{mem_pw}, #{mem_name}, #{mem_age}, #{mem_email}, 1, 0, 1, SYSDATE)"})
	public int joinMember(Sports_Member vo);
	
	@Select({"SELECT * FROM SPORTS_MEMBER WHERE ", 
			" MEM_ID = #{mem_id} AND MEM_PW = #{mem_pw} AND MEM_CHECK = 1"})
	public Sports_Member loginMember(Sports_Member vo);
	
	public Sports_Member selectMemberOne(String id);
	
	public int updateMemberOne(Sports_Member vo);
	
	@Select({"SELECT * FROM SPORTS_MEMBER ",
			" WHERE (MEM_ID != #{myid} AND MEM_ID LIKE #{mem}||'%') ",
			" OR (MEM_NAME != #{myname} AND MEM_NAME LIKE #{mem}||'%')"})
	public List<Sports_Member> searchMemberList(
			@Param("mem") String mem,
			@Param("myid") String myid,
			@Param("myname") String myname);
	
	@Select({"<script>",
			"SELECT MEM_ID, MEM_NAME, l.LEVEL_NAME FROM SPORTS_MEMBER m JOIN SPORTS_MEM_LEVEL l ON m.LEVEL_NO = l.LEVEL_NO WHERE MEM_ID IN ",
			" <foreach collection='list' item='item' index='index' separator=',' open='(' close=')'> ",
			" #{item} ",
			" </foreach>",
			"</script>"})
	public List<Sports_Member> selectMemberList(@Param("list") String[] id_list);
}
