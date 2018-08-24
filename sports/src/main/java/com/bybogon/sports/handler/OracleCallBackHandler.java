package com.bybogon.sports.handler;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.springframework.jdbc.support.nativejdbc.CommonsDbcpNativeJdbcExtractor;
import org.springframework.util.StringUtils;

import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

public class OracleCallBackHandler implements TypeHandler<Object> {

	@Override
	public Object getResult(ResultSet rs, String columnName) throws SQLException {
	 String value = "";
	 try {
	  if (!StringUtils.isEmpty(rs.getString(columnName))) {
	   value = new String(rs.getString(columnName).getBytes("8859_1"), "KSC5601");
	  }
	 } catch (Exception e) {
	  e.printStackTrace();
	 }
	 return value;
	}
	 
	@Override
	public Object getResult(ResultSet arg0, int arg1) throws SQLException {
	 return null;
	}
	 
	@Override
	public Object getResult(CallableStatement cs, int columnIndex) throws SQLException {
	 return cs.getString(columnIndex);
	}
	 
	@Override
	public void setParameter(PreparedStatement ps, int i, Object parameter, JdbcType arg3) throws SQLException {
	 CommonsDbcpNativeJdbcExtractor extractor = new CommonsDbcpNativeJdbcExtractor();
	 Connection conn = extractor.getNativeConnection(ps.getConnection());
	 ArrayDescriptor desc = ArrayDescriptor.createDescriptor("FLOAT_ARRAY_TABLE", conn);
	 // parameter = new ARRAY(desc, conn, ((ArrayList) parameter).toArray());
	 parameter = new ARRAY(desc, conn, (String[]) parameter);
	 ps.setArray(i, (oracle.sql.ARRAY) parameter);
	}


}
