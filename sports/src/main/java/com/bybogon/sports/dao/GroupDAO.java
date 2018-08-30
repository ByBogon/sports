package com.bybogon.sports.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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


}
