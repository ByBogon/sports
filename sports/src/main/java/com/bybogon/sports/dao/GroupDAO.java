package com.bybogon.sports.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bybogon.sports.vo.Sports_Member;

public interface GroupDAO {
	
	@Select({"SELECT * FROM SPORTS_MEMBER WHERE MEM_ID NOT LIKE #{mem_id} AND SPORTS_NO = #{no}"})
	public List<Sports_Member> selectMemberList(@Param("no") int no, @Param("mem_id") String mem_id);

}
