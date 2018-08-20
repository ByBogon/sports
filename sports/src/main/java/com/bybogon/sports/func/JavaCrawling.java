package com.bybogon.sports.func;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.google.code.geocoder.GeoAddressService;
import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.LatLng;


public class JavaCrawling {
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
	
	
	public static LatLng geocoding(String location) throws IOException {
		//location = "";
		final Geocoder geocoder = new Geocoder();
		GeoAddressService serv = new GeoAddressService(geocoder);
		LatLng addr = serv.getLatLngPointsByAddress(location);
		
		//System.out.println(addr);
		return addr;
	}
	
	
	public static int insertCenter(int areaNo, String name, String addr, String tel, String detail) {
		try {
			testOracle();
			String sql = "INSERT INTO SPORTS_CENTER( "
					+ " CENTER_NO, CENTER_AREA_NO, CENTER_NAME, CENTER_ADDR, CENTER_TEL, "
					+ " CENTER_DETAIL, CENTER_REG_CHK, SPORTS_NO, CENTER_REG_DATE) "
					+ " VALUES(SEQ_SPORTS_CENTER_NO.NEXTVAL,?,?,?,?,?,0,0,SYSDATE)";
	
			PreparedStatement ps = OracleConnStatic.getConn().prepareStatement(sql);
			
			ps.setInt(1, areaNo);
			ps.setString(2, name);
			ps.setString(3, addr);
			ps.setString(4, tel);
			ps.setString(5, detail);
	
			return ps.executeUpdate(); // INSERT, UPDATE, DELETE는 뒤에 Update
	
		} catch (Exception e) {
			System.out.println(e.getMessage() + "sports");
			return 0;
		}
	
	}
	public static int updateCenter(int centerNo, String centerName) {
		try {
			testOracle();
			String sql = "UPDATE SPORTS_CENTER SET "
					+ " CENTER_NAME = ? "
					+ " WHERE CENTER_NO = ?";
	
			PreparedStatement ps = OracleConnStatic.getConn().prepareStatement(sql);

			ps.setString(1, centerName);
			ps.setInt(2, centerNo);
	
			return ps.executeUpdate(); // INSERT, UPDATE, DELETE는 뒤에 Update
	
		} catch (Exception e) {
			System.out.println(e.getMessage() + "sports");
			return 0;
		}
	}


	public static void main(String[] args) throws Exception{
		System.out.println("START");
		String URL = "http://map.squash.pe.kr/bbs/board.php?bo_table=KoreaSquashCourt";
        Document doc = null;
        try {
        	doc = Jsoup.connect(URL).get();
        } catch (IOException e) {
        	e.printStackTrace();
        }
        Elements elem = doc.select("div.list-table");
        int index = 0;
        for (Element el : elem.select("tr > td")) {
        	String str = el.text();
        	int addr_idx = str.indexOf("▩");
        	int tel_idx = str.indexOf("☎");
        	if(addr_idx > 0 || tel_idx > 0) {
        		index++;
        		String centerName = str.substring(str.indexOf("]")+1, addr_idx);
        		System.out.println("NOW: "+index);
        		//System.out.println(centerName.trim());
        		//System.out.println(str);
            	//updateCenter(index, centerName.trim());
        		int area_no = 0;
        		String addr = "";
	        	String tel = "";
	        	String areaName = str.substring(str.indexOf("[")+1, str.indexOf("]"));
	        	areaName = areaName.trim();
	        	//System.out.println("+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+");
	        	//System.out.println("START!!!!!!!!!!!!!!!!!!!!!!!!!!");
	        	//System.out.println("idx: "+addr_idx);
	        	addr = str.substring(addr_idx+1, tel_idx);
	        	//System.out.println(areaName);
	        	if(areaName.equals("서울")) {
	        		area_no = 10;
	        	} else if (areaName.equals("부산")) {
	        		area_no = 11;
	        	} else if (areaName.equals("대구")) {
	        		area_no = 12;
	        	} else if (areaName.equals("인천")) {
	        		area_no = 13;
	        	} else if (areaName.equals("광주")) {
	        		area_no = 14;
	        	} else if (areaName.equals("대전")) {
	        		area_no = 15;
	        	} else if (areaName.equals("울산")) {
	        		area_no = 16;
	        	} else if (areaName.equals("세종")) {
	        		area_no = 17;
	        	} else if (areaName.equals("경기도")) {
	        		area_no = 18;
	        	} else if (areaName.equals("강원도")) {
	        		area_no = 19;
	        	} else if (areaName.equals("충청북도")) {
	        		area_no = 20;
	        	} else if (areaName.equals("충청남도")) {
	        		area_no = 21;
	        	} else if (areaName.equals("전라북도")) {
	        		area_no = 22;
	        	} else if (areaName.equals("전라남도")) {
	        		area_no = 23;
	        	} else if (areaName.equals("경상북도")) {
	        		area_no = 24;
	        	} else if (areaName.equals("경상남도")) {
	        		area_no = 25;
	        	} else if (areaName.equals("제주도")) {
	        		area_no = 26;
	        	} else {
	        		area_no = 99;
	        	}
	       
	        	//System.out.println("주소: "+addr+"/ 행정번호: "+area_no);
	        	//System.out.println(str);
	        	//System.out.println("======================");
	        	//System.out.println("AreaName: " + areaName);
	        	//System.out.println("======================");
	        	tel = str.substring(tel_idx+1);
	        	//System.out.println("tel: "+ tel);
	        	//System.out.println("======================");
	        	//String tels[] = tel.trim().split("-");
	        	
	        	//tel을 -으로 나눠서 for문 돌려서 공백으로 시작하면 그이후로 info
	        	String tel2[] = tel.trim().split(" ", 2);
	        	String total_phone = "";
	        	String total_info2 = "";
	        	StringBuilder phone = new StringBuilder();
	        	StringBuilder strbuilder2 = new StringBuilder();
	        	
	        	for(int i=0; i<tel2.length; i++) {
	        		if(i==1) {
	        			strbuilder2.append(tel2[i]);
	        			total_info2 += tel2[i];
	        		} else {
	        			phone.append(tel2[i]);
	        		}
	        	}
	        	total_phone = phone.toString();
	        	total_info2 = strbuilder2.toString();
	        	//System.out.println("final_total_phone: "+total_phone);
	        	//System.out.println("final_total_info2: "+total_info2);
	        	
	        	LatLng gps = geocoding(addr);
	        			        	
	        	System.out.println("===============================================");
	        	System.out.println("FINAL!!!!!!!!!!!!!!!!!!!!!");
	        	System.out.println("AreaNo: "+area_no);
		        System.out.println("======================");
		        System.out.println("CenterName: "+centerName.trim());
		        System.out.println("======================");
	        	System.out.println("AreaName: "+areaName);
		        System.out.println("======================");
		        System.out.println("Addr: "+addr);
		        System.out.println("======================");
		        System.out.println("Tel: "+ total_phone);
		        System.out.println("======================");
		        System.out.println("Info: "+total_info2);
		        System.out.println("======================");
		        System.out.println("LATLNG: "+gps);
		        System.out.println("======================");
		        
		        //이안에서 디비로 insert
		        /*int ret = insertCenter(addr, total_phone, total_info2, area_no);
		        System.out.println(ret);*/
	        }
        	System.out.println("Last: "+index);
		}
        System.out.println("END");
    }
}
