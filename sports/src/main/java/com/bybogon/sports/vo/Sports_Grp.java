package com.bybogon.sports.vo;

public class Sports_Grp {
	private int grp_no = 0;
	private String grp_name = null;
	private String grp_date = null;
	private int grp_chk = 0;
	private int sports_no = 0;
	private String grp_mem = null;
	private String grp_leader = null;
	private String grp_center = null;
	private String grp_mainimg = null;
	private String grp_detail = null;
	
	private int cnt = 0;
	
	private int center_no = 0;
	private String center_name = null;
	private String center_addr = null;
	private float center_lat = 0;
	private float center_lng = 0;
	
	
	private String mem_id = null;
	private String mem_name = null;
	
	public Sports_Grp() {
		super();
	}

	public Sports_Grp(int grp_no, String grp_name, String grp_mainimg) {
		super();
		this.grp_no = grp_no;
		this.grp_name = grp_name;
		this.grp_mainimg = grp_mainimg;
	}

	public Sports_Grp(String grp_name, String grp_leader, String grp_detail, String grp_center, int center_no) {
		super();
		this.grp_name = grp_name;
		this.grp_leader = grp_leader;
		this.grp_detail = grp_detail;
		this.grp_center = grp_center;
		this.center_no= center_no;
	}
	
	public String getCenter_name() {
		return center_name;
	}

	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}

	public String getCenter_addr() {
		return center_addr;
	}

	public void setCenter_addr(String center_addr) {
		this.center_addr = center_addr;
	}

	public float getCenter_lat() {
		return center_lat;
	}

	public void setCenter_lat(float center_lat) {
		this.center_lat = center_lat;
	}

	public float getCenter_lng() {
		return center_lng;
	}

	public void setCenter_lng(float center_lng) {
		this.center_lng = center_lng;
	}

	public String getGrp_detail() {
		return grp_detail;
	}

	public void setGrp_detail(String grp_detail) {
		this.grp_detail = grp_detail;
	}

	public String getGrp_mainimg() {
		return grp_mainimg;
	}

	public void setGrp_mainimg(String grp_mainimg) {
		this.grp_mainimg = grp_mainimg;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getGrp_mem() {
		return grp_mem;
	}

	public void setGrp_mem(String grp_mem) {
		this.grp_mem = grp_mem;
	}
	

	public int getGrp_no() {
		return grp_no;
	}

	public void setGrp_no(int grp_no) {
		this.grp_no = grp_no;
	}

	public String getGrp_center() {
		return grp_center;
	}


	public void setGrp_center(String grp_center) {
		this.grp_center = grp_center;
	}


	public String getGrp_leader() {
		return grp_leader;
	}
	public void setGrp_leader(String grp_leader) {
		this.grp_leader = grp_leader;
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
		return "Sports_Grp [grp_no=" + grp_no + ", grp_name=" + grp_name + ", sports_no=" + sports_no + ", grp_mem="
				+ grp_mem + ", grp_leader=" + grp_leader + ", grp_center=" + grp_center + "]";
	}
	
}
