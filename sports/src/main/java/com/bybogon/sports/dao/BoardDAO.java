package com.bybogon.sports.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.type.JdbcType;

import com.bybogon.sports.vo.Sports_Brd;

public interface BoardDAO {
	@Options(useGeneratedKeys=false)
	@Update({"UPDATE SPORTS_BRD SET ",
			" BRD_CONTENT = #{vo.brd_content}, ",
			" BRD_IMG = #{vo.brd_img} ",
			" WHERE BRD_WRITER = #{vo.brd_writer} AND BRD_NO = #{vo.brd_no} AND BRD_CHECK = 1"
	})
	public int updateBoardOne(@Param("vo") Sports_Brd vo);
	
	
	@Options(useGeneratedKeys=false)
	@Update({"UPDATE SPORTS_BRD ",
			" SET BRD_CHECK = 0 ",
			" WHERE BRD_NO = #{brd_no}"
	})
	public int deleteOneBoard(@Param("brd_no") int brd_no);
	
	@Options(useGeneratedKeys=false)
	@Update({"UPDATE SPORTS_BRD_REPLY ",
			" SET RPL_CONTENT = #{rpl_content} ",
			" WHERE RPL_NO = #{rpl_no}"
	})
	public int updateCommentOnBoard(
			@Param("rpl_no") int rpl_no, 
			@Param("rpl_content") String rpl_content);
	
	@Delete({"DELETE FROM SPORTS_BRD_REPLY WHERE RPL_NO = #{rpl_no}"})
	public int deleteCommentOnBoard(@Param("rpl_no") int rpl_no);
	
	@Results(id = "commentsList", value = {
			@Result(property = "RPL_NO", column = "RPL_NO"),
			@Result(property = "RPL_CONTENT", column = "RPL_CONTENT", jdbcType = JdbcType.CLOB, javaType = String.class),
			@Result(property = "RPL_WRITER", column = "RPL_WRITER"),
			@Result(property = "RPL_DATE", column = "RPL_DATE"),
			@Result(property = "MEM_NAME", column = "MEM_NAME"),
			@Result(property = "MEM_IMG", column = "MEM_IMG"),
	})
	@Select({"SELECT RPL_NO, RPL_CONTENT, RPL_WRITER, RPL_DATE, MEM_NAME, MEM_IMG FROM SPORTS_BRD_REPLY r ",
			" JOIN SPORTS_MEMBER m ON RPL_WRITER = MEM_ID",
			" WHERE BRD_NO = #{brd_no} AND BRD_CHECK = 1", 
			" ORDER BY RPL_DATE DESC"})
	public List<Map<String, Object>> selectCommentsListOnBoard(
			@Param("brd_no") int brd_no);
	
	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_BRD ",
			"(BRD_NO, BRD_CONTENT, BRD_WRITER, BRD_DATE, BRD_GROUP, BRD_CHECK, BRD_IMG) ",
			"VALUES ",
			"(SEQ_SPORTS_BRD_NO.NEXTVAL, #{vo.brd_content}, #{vo.brd_writer}, SYSDATE, #{vo.brd_group}, 1, #{vo.brd_img} )"
	})
	public int insertBoardOne(@Param("vo") Sports_Brd vo);
	
	@Select({"SELECT ", 
			"    cnt, MEM_NAME, MEM_IMG, b.* ", 
			"FROM SPORTS_BRD b ", 
			"LEFT JOIN ( ", 
			"    SELECT ", 
			"        COUNT(*) cnt, r.BRD_NO ", 
			"    FROM SPORTS_BRD_REPLY r, SPORTS_BRD b ", 
			"    WHERE r.BRD_NO = b.BRD_NO AND BRD_GROUP = #{grp_no} GROUP BY r.BRD_NO ", 
			") r ON r.BRD_NO = b.BRD_NO ", 
			"JOIN SPORTS_MEMBER m ON m.MEM_ID = BRD_WRITER " ,
			"WHERE BRD_GROUP = #{grp_no} AND BRD_CHECK = 1 ORDER BY BRD_DATE DESC ", 
	})
	public List<Sports_Brd> selectBoardOne(@Param("grp_no") int grp_no);

	
	@Options(useGeneratedKeys=false)
	@Insert({"INSERT INTO SPORTS_BRD_REPLY ",
			"(RPL_NO, RPL_CONTENT, RPL_WRITER, BRD_NO, RPL_DATE) ",
			"VALUES ",
			"(SEQ_SPORTS_BRD_REPL_NO.NEXTVAL, #{rpl_content}, #{rpl_writer}, #{brd_no}, SYSDATE)"
	})
	public int insertCommentOnBoard(
			@Param("brd_no") int brd_no,
			@Param("rpl_content") String rpl_content,
			@Param("rpl_writer") String rpl_writer);
	
}
