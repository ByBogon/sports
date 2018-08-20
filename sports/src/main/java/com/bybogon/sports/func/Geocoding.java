package com.bybogon.sports.func;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.google.code.geocoder.GeoAddressService;
import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.GeocoderResult;
import com.google.code.geocoder.model.GeocoderStatus;
import com.google.code.geocoder.model.LatLng;

public class Geocoding {
	private static Connection conn;
	private static Statement stat;
	private static ResultSet rs;

	public static void main(String[] args) throws Exception{
		String location = " 서울시 서초구 신반포로 176  ";

		//Float[] coords = CommonUtil.performGeoCoding(location);
		//System.out.println(location + ": " + coords[0] + ", " + coords[1]);
		final Geocoder geocoder = new Geocoder();
		GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(location).
				setLanguage("kr").getGeocoderRequest(); 
		
		GeocodeResponse geocoderResponse = geocoder.geocode(geocoderRequest);
		GeoAddressService serv = new GeoAddressService(geocoder);
		LatLng addr = serv.getLatLngPointsByAddress(location);
		
		System.out.println(addr);
		
		//System.out.println(geocoderResponse);
		System.out.println(geocoderResponse.getResults());
		
	}
	
	public static Float[] geoCoding(String location) {
		if (location == null)  
			return null;
		
		Geocoder geocoder = new Geocoder();
		// setAddress : 변환하려는 주소 (경기도 성남시 분당구 등)
		// setLanguate : 인코딩 설정
		GeocoderRequest geocoderRequest = new GeocoderRequestBuilder().setAddress(location).setLanguage("ko").getGeocoderRequest();
		GeocodeResponse geocoderResponse;
		try {
			geocoderResponse = geocoder.geocode(geocoderRequest);
			if (geocoderResponse.getStatus() == GeocoderStatus.OK & !geocoderResponse.getResults().isEmpty()) {
				GeocoderResult geocoderResult=geocoderResponse.getResults().iterator().next();
				LatLng latitudeLongitude = geocoderResult.getGeometry().getLocation();
				Float[] coords = new Float[2];
				coords[0] = latitudeLongitude.getLat().floatValue();
				coords[1] = latitudeLongitude.getLng().floatValue();
				return coords;
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return null;
	}
	

	
	public static int insertCenter(String addr, String tel, String detail, int areaNo) {
		try {
			testOracle();
			String sql = "INSERT INTO SPORTS_CENTER("
					+ " CENTER_NO, CENTER_ADDR, CENTER_TEL, CENTER_REG_CHK, SPORTS_NO, CENTER_DETAIL, CENTER_AREA_NO)"
					+ " VALUES(SEQ_SPORTS_CENTER_NO.NEXTVAL,?,?,0,0,?,?)";
	
			PreparedStatement ps = OracleConnStatic.getConn().prepareStatement(sql);
	
			ps.setString(1, addr);
			ps.setString(2, tel);
			ps.setString(3, detail);
			ps.setInt(4, areaNo);
	
			return ps.executeUpdate(); // INSERT, UPDATE, DELETE는 뒤에 Update
	
		} catch (Exception e) {
			System.out.println(e.getMessage() + "sports");
			return 0;
		}
	
	}
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

}
