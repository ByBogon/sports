package com.bybogon.sports.vo;

public class Sports_Grp {
	private String grp_no = null;
	private String grp_name = null;
	private String grp_date = null;
	private int grp_chk = 0;
	private int sports_no = 0;
	private String grp_mem = null;
	private String grp_leader = null;
	private String grp_center = null;
	private String grp_mainimg = null;
	private int cnt = 0;
	
	private int center_no = 0;
	
	private String mem_id = null;
	private String mem_name = null;
	
	public Sports_Grp() {
		super();
	}

	public Sports_Grp(String grp_name, String grp_leader) {
		super();
		this.grp_name = grp_name;
		this.grp_leader = grp_leader;
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
	

	public String getGrp_no() {
		return grp_no;
	}

	public void setGrp_no(String grp_no) {
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
