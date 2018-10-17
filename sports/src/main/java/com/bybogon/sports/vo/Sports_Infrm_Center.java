package com.bybogon.sports.vo;

public class Sports_Infrm_Center {
	private int infrm_center_no;
	private String infrm_center_area_no = null;
	private String infrm_center_name = null;
	private String infrm_center_addr = null;
	private String infrm_center_tel = null;
	private String infrm_center_detail = null;
	private float infrm_center_lat = 0;
	private float infrm_center_lng = 0;
	private int infrm_center_reg_check = 0;
	private int sports_no = 0;
	private String infrm_center_reg_date = null;
	
	public Sports_Infrm_Center() {
		super();
	}
	
	public Sports_Infrm_Center(String infrm_center_name) {
		super();
		this.infrm_center_name = infrm_center_name;
	}

	public Sports_Infrm_Center(String infrm_center_name, String infrm_center_addr) {
		super();
		this.infrm_center_name = infrm_center_name;
		this.infrm_center_addr = infrm_center_addr;
	}

	public Sports_Infrm_Center(String infrm_center_name, String infrm_center_addr, String infrm_center_detail) {
		super();
		this.infrm_center_name = infrm_center_name;
		this.infrm_center_addr = infrm_center_addr;
		this.infrm_center_detail = infrm_center_detail;
	}



	public int getInfrm_center_no() {
		return infrm_center_no;
	}
	public void setInfrm_center_no(int infrm_center_no) {
		this.infrm_center_no = infrm_center_no;
	}
	public String getInfrm_center_area_no() {
		return infrm_center_area_no;
	}
	public void setInfrm_center_area_no(String infrm_center_area_no) {
		this.infrm_center_area_no = infrm_center_area_no;
	}
	public String getInfrm_center_name() {
		return infrm_center_name;
	}
	public void setInfrm_center_name(String infrm_center_name) {
		this.infrm_center_name = infrm_center_name;
	}
	public String getInfrm_center_addr() {
		return infrm_center_addr;
	}
	public void setInfrm_center_addr(String infrm_center_addr) {
		this.infrm_center_addr = infrm_center_addr;
	}
	public String getInfrm_center_tel() {
		return infrm_center_tel;
	}
	public void setInfrm_center_tel(String infrm_center_tel) {
		this.infrm_center_tel = infrm_center_tel;
	}
	public String getInfrm_center_detail() {
		return infrm_center_detail;
	}
	public void setInfrm_center_detail(String infrm_center_detail) {
		this.infrm_center_detail = infrm_center_detail;
	}
	public float getInfrm_center_lat() {
		return infrm_center_lat;
	}
	public void setInfrm_center_lat(float infrm_center_lat) {
		this.infrm_center_lat = infrm_center_lat;
	}
	public float getInfrm_center_lng() {
		return infrm_center_lng;
	}
	public void setInfrm_center_lng(float infrm_center_lng) {
		this.infrm_center_lng = infrm_center_lng;
	}
	public int getInfrm_center_reg_check() {
		return infrm_center_reg_check;
	}
	public void setInfrm_center_reg_check(int infrm_center_reg_check) {
		this.infrm_center_reg_check = infrm_center_reg_check;
	}
	public int getSports_no() {
		return sports_no;
	}
	public void setSports_no(int sports_no) {
		this.sports_no = sports_no;
	}
	public String getInfrm_center_reg_date() {
		return infrm_center_reg_date;
	}
	public void setInfrm_center_reg_date(String infrm_center_reg_date) {
		this.infrm_center_reg_date = infrm_center_reg_date;
	}
}
