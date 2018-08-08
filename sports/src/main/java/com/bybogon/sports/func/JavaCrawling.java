package com.bybogon.sports.func;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.jsoup.Jsoup;
import org.jsoup.helper.StringUtil;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class JavaCrawling {
/*
	private static Connection conn;
	private static Statement stat;
	private static ResultSet rs;

	public static void testOracle() {
	    String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	    String id = "hr";
	    String pwd = "1234";
	     
	    try {
	        Class.forName("oracle.jdbc.driver.OracleDriver");
	        conn = DriverManager.getConnection(dbUrl, id, pwd);
	        stat = conn.createStatement();
	        System.out.println("DB접속 성공");
	        stat.close();
	        conn.close();

	        System.out.println("DB연결 해제");
	         
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	*/
	
	/*public int insertBoard(V1_Board vo) {
		try {
			String sql = "INSERT INTO V1_BOARD("
					+ " BRD_NO, BRD_TITLE, BRD_CONTENT, BRD_WRITER, BRD_HIT, BRD_DATE, BRD_FILE)"
					+ " VALUES(SEQ_V1_BOARD_NO.NEXTVAL,?,?,?,0,SYSDATE,?)";
	
			PreparedStatement ps = OracleConnStatic.getConn().prepareStatement(sql);
	
			ps.setString(1, vo.getBrd_title());
			ps.setString(2, vo.getBrd_content());
			ps.setString(3, vo.getBrd_writer());
			ps.setString(4, vo.getBrd_file());
	
			return ps.executeUpdate(); // INSERT, UPDATE, DELETE는 뒤에 Update
	
		} catch (Exception e) {
			System.out.println(e.getMessage() + "BoardDAO");
			return 0;
		}
	
	}*/


	public static void main(String[] args) throws Exception{
		System.out.println("START");
		//for(int i = 1; i <= 19; i++) {
			//String URL = "http://koreasquash.or.kr/_guide-club.asp?sido=&page="+i;
			String URL = "http://map.squash.pe.kr/bbs/board.php?bo_table=KoreaSquashCourt";
	        Document doc = null;
	        try {
	        	doc = Jsoup.connect(URL).get();
	        } catch (IOException e) {
	        	e.printStackTrace();
	        }
	        Elements elem = doc.select("div.list-table");
	        for (Element el : elem.select("tr > td")) {
	        	String str = el.text();
	        	String areaNo = "";
	        	String addr = "";
	        	String tel = "";
	        	String detail = "";
	        	int addr_idx = str.indexOf("▩");
	        	int tel_idx = str.indexOf("☎");
	        	if(addr_idx > 0 || tel_idx > 0) {
		        	System.out.println("idx: "+addr_idx);
		        	addr = str.substring(addr_idx+1, tel_idx);
		        	System.out.println(str);
			        System.out.println("======================");
		        	tel = str.substring(tel_idx+1);
		        	System.out.println("tel: "+ tel);
			        System.out.println("======================");
		        	String tels[] = tel.trim().split("-");
		        	String lastTel = "";
		        	//String 
		        	for(int i=0; i<tels.length; i++) {
		        		System.out.println("tels:" + tels[i]);
		        		/*if (tels[0].length() == 4) {
		        			tels[2] = "";
		        			break;
		        		}*/
		        		if(i==2) {
		        			lastTel = tels[i];
		        			lastTel = lastTel.substring(0, 4);
		        			System.out.println("lastTel: "+lastTel);
		        			tels[i] = lastTel;
		        		}
		        		
		        	}
		        	for(String tmp : tels) {
			        	System.out.println("Tels[]: "+tmp);	
		        	}
		        	String final_tels[] = new String[3];
		        	
		        	String info = "";
		        	for(int i=0; i<tels.length; i++) {
		        		System.out.println(i+" length: "+tels.length);
		        		System.out.println(i+" final tels: "+tels[i]);
		        		if(tels.length>2) {
		        			System.out.println(i+" if");
		        			if(i < 3) {
			        			final_tels[i] = tels[i];

				        		System.out.println(i+" final tels[]: "+final_tels[i]);
			        		} else if (i >= 3) {
			        			System.out.println(i+" aaaaaaaaaaa: "+i);
			        			info += tels[i];
			        			System.out.println(i+" info[]: "+info);
			        			detail += info;
			        		}
		        		} else {
		        			System.out.println(i+" else");
		        			final_tels[i] = tels[i];
			        		System.out.println(i+" final tels[]: "+final_tels[i]);
		        			if(i == 3) {
		        				info += tels[i];
		        				System.out.println(i+" info[]: "+info);
		        				detail += info;
		        			}
		        		}
		        		
		        		
		        	}
		        	
			        int areaNo_idx = tel.indexOf("-");
			        if (areaNo_idx > 0) {
			        	System.out.println(areaNo_idx);
			        	areaNo = tel.substring(0, areaNo_idx);
			        	if (areaNo.trim().length() == 2) {
			        		
			        	}
			        	
			        	System.out.println(areaNo);
				        System.out.println("======================");
				        System.out.println(addr);
				        System.out.println("======================");
				        System.out.println(tel);
				        System.out.println("======================");
				        System.out.println("detail: "+detail);
				        System.out.println("======================");
		        	}
	        	}
	        }
	        //System.out.println("======================");
		//}
		System.out.println("END");
        
    }


}
