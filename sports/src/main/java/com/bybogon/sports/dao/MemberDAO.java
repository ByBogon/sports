package com.bybogon.sports.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import com.bybogon.sports.vo.Sports_Member;

public interface MemberDAO {
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_MEMBER(MEM_ID, MEM_PW, MEM_NAME, MEM_AGE, MEM_EMAIL, MEM_CHECK, SPORTS_NO, LEVEL_NO,  MEM_DATE) ",
		" VALUES(#{mem_id}, #{mem_pw}, #{mem_name}, #{mem_age}, #{mem_email}, 1, 0, 1, SYSDATE)"})
	public int joinMember(Sports_Member vo);
	
	@Select({"SELECT * FROM SPORTS_MEMBER WHERE ", 
			" MEM_ID = #{mem_id} AND MEM_PW = #{mem_pw} AND MEM_CHECK = 1"})
	public Sports_Member loginMember(Sports_Member vo);
	
	public Sports_Member selectMemberOne(String id);
	
	public int updateMemberOne(Sports_Member vo);
}
