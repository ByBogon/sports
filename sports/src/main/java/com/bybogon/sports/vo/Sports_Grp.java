package com.bybogon.sports.vo;

import java.util.HashMap;
import java.util.Map;

public class Sports_Grp {
	private int grp_no = 0;
	private String grp_name = null;
	private String grp_date = null;
	private int grp_chk = 0;
	private int sports_no = 0;
	
	private int center_no = 0;
	
	private String mem_id = null;
	private String mem_name = null;
	
	private Map<String, Object> map = null;
	
	public Sports_Grp() {
		super();
		map = new HashMap<String, Object>();
		map.put("0", "스쿼시");
		map.put("1", "농구");
		map.put("2", "테니스");
	}
	
	
	public Map<String, Object> getMap() {
		return map;
	}



	public void setMap(Map<String, Object> map) {
		this.map = map;
	}



	public int getGrp_no() {
		return grp_no;
	}

	public void setGrp_no(int grp_no) {
		this.grp_no = grp_no;
	}

	public String getGrp_name() {
		return grp_name;
	}

	public void setGrp_name(String grp_name) {
		this.grp_name = grp_name;
	}

	public String getGrp_date() {
		return grp_date;
	}

	public void setGrp_date(String grp_date) {
		this.grp_date = grp_date;
	}

	public int getGrp_chk() {
		return grp_chk;
	}

	public void setGrp_chk(int grp_chk) {
		this.grp_chk = grp_chk;
	}

	public int getSports_no() {
		return sports_no;
	}

	public void setSports_no(int sports_no) {
		this.sports_no = sports_no;
	}

	public int getCenter_no() {
		return center_no;
	}

	public void setCenter_no(int center_no) {
		this.center_no = center_no;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	@Override
	public String toString() {
		return "Sports_Grp [grp_no=" + grp_no + ", grp_name=" + grp_name + ", grp_date=" + grp_date + ", grp_chk="
				+ grp_chk + ", sports_no=" + sports_no + ", center_no=" + center_no + ", mem_id=" + mem_id
				+ ", mem_name=" + mem_name + "]";
	}

}
