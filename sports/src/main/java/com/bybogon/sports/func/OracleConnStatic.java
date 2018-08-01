package com.bybogon.sports.func;

import java.sql.Connection;
import java.sql.DriverManager;


public class OracleConnStatic {
	public static Connection getConn() {
		String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	    String id = "hr";
	    String pw = "1234";
		try {
			//1. Driver 설치 - ojdbc6.jar 파일이 있어야함.
			Class.forName("oracle.jdbc.driver.OracleDriver"); // Maven 에 라이브러리 추가한것. (ojbdc6-11.2.0.3.jar)
			//2. DB 접속(접속할 서버주소, 아이디, 암호 필요)
			Connection conn = DriverManager.getConnection(
					dbUrl, id, pw);
			System.out.println("오라클 접속 성공1");
			return conn;			
		} catch (Exception e) {
			System.out.println("오라클 접속 오류");
			System.out.println(e.getMessage());
			return null;
		}
		
	}
}
