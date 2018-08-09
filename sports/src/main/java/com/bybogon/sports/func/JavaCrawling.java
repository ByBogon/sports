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
	        	int addr_idx = str.indexOf("▩");
	        	int tel_idx = str.indexOf("☎");
	        	if(addr_idx > 0 || tel_idx > 0) {
	        		String addr = "";
		        	String tel = "";
		        	String detail = "";
		        	String lastTel = "";
		        	String lastInfo = "";
		        	String areaName = str.substring(str.indexOf("[")+1, str.indexOf("]"));
		        	//System.out.println("+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+");
		        	System.out.println("START!!!!!!!!!!!!!!!!!!!!!!!!!!");
		        	//System.out.println("idx: "+addr_idx);
		        	addr = str.substring(addr_idx+1, tel_idx);
		        	//System.out.println(str);
			        //System.out.println("======================");
		        	//System.out.println("AreaName: " + areaName);
		        	//System.out.println("======================");
		        	tel = str.substring(tel_idx+1);
		        	System.out.println("tel: "+ tel);
		        	System.out.println("======================");
		        	//String tels[] = tel.trim().split("-");
		        	
		        	//tel을 -으로 나눠서 for문 돌려서 공백으로 시작하면 그이후로 info
		        	String tel2[] = tel.trim().split("-");
		        	String total_phone = "";
		        	String total_info2 = "";
		        	StringBuilder phone = new StringBuilder();
		        	StringBuilder strbuilder2 = new StringBuilder();
		        	
		        	for(int i=0; i<tel2.length; i++) {
		        		if(tel2[i].startsWith(" ")) {
		        			//strbuilder2.append(tel2[i]);
		        			total_info2 += tel2[i];
		        			System.out.println(total_info2);
		        		} else {
		        			phone.append(tel2[i]);
		        			phone.append("-");
		        			System.out.println(phone);
		        		}
		        	}
		        	total_phone = phone.toString();
		        	//total_info2 = strbuilder2.toString();
		        	System.out.println("total_phone: "+total_phone);
		        	System.out.println("total_info2: "+total_info2);
		        	//tel을 공백으로 나눠서 전화번호(-포함)이 tels[0]이 되고
		        	//tels[0]을 전화번호로, 그외에 것들은 info에 넣기
		        	
		        	/*String tel1[] = tel.trim().split(" ");
		        	String total_tel = "";
		        	String total_info = "";
		        	StringBuilder strbuilder = new StringBuilder();
		        	for(int i=0; i<tel1.length; i++) {
		        		System.out.println(tel1[i]);
		        		if(i==0) {
		        			total_tel = tel1[0];
		        			System.out.println("total tel: "+total_tel);
		        		} else {
		        			strbuilder.append(tel1[i]);
		        		}
		        	}
		        	total_info = strbuilder.toString();
		        	System.out.println("total info: "+total_info);*/
		        	
		        	/*for(int i=0; i<tels.length; i++) {
		        		//System.out.println("tels length: "+ tels.length);
		        		//System.out.println("tels:" + tels[i]);
		        		if(i==2) {
		        			lastInfo += tels[i].substring(4);
		        			//System.out.println("lastInfo: "+lastInfo);
		        			lastTel = tels[i];
		        			lastTel = lastTel.substring(0, 4);
		        			//System.out.println("lastTel: "+lastTel);
		        			tels[i] = lastTel;
		        		}
		        		if(i>2) {
		        			lastInfo += tels[i];
		        			//System.out.println("lastInfo: "+lastInfo);
		        		}
		        		
		        	}
		        	
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
		        	
		        	
		        	StringBuilder builder = new StringBuilder();
		        	for(String s : tels) {
		        		builder.append(s);
		        	}
		        	String fullTel = builder.toString();
		        	System.out.println("===============================================");
		        	System.out.println("FINAL!!!!!!!!!!!!!!!!!!!!!");
		        	System.out.println("AreaName: "+areaName);
			        System.out.println("======================");
			        System.out.println("Addr: "+addr);
			        System.out.println("======================");
			        System.out.println("Tel:"+ fullTel);
			        System.out.println("======================");
			        System.out.println("lastInfo: "+lastInfo);
			        System.out.println("======================");*/
			        
			        //이안에서 디비로 insert
	        	}
	        }
		System.out.println("END");
    }
}
