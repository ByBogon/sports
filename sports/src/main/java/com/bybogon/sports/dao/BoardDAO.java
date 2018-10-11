package com.bybogon.sports.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bybogon.sports.vo.Sports_Brd;

public interface BoardDAO {
	
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
			"WHERE BRD_GROUP = #{grp_no} ORDER BY BRD_DATE DESC ", 
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
