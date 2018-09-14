package com.bybogon.sports.vo;

public class Sports_Member {
	private String mem_id = null;
	private String mem_pw = null;
	private String mem_name = null;
	private int mem_age = 0;
	private String mem_email = null;
	private String center_name = null;
	private int mem_check = 0;
	private int sports_no = 0;
	private int level_no = 0;
	private String level_name = null;
	private String mem_date = null;
	private String mem_img = null;
	private String mem_detail= null;
	private int mcnt= 0;
	
	public Sports_Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Sports_Member(String mem_id, String mem_pw) {
		super();
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
	}

	public Sports_Member(String mem_id, String mem_name, int mem_age, String mem_email, String mem_img,
			String mem_detail) {
		super();
		this.mem_id = mem_id;
		this.mem_name = mem_name;
		this.mem_age = mem_age;
		this.mem_email = mem_email;
		this.mem_img = mem_img;
		this.mem_detail = mem_detail;
	}

	public Sports_Member(String mem_id, String mem_pw, String mem_name, int mem_age, String mem_email, String mem_img,
			String mem_detail) {
		super();
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_name = mem_name;
		this.mem_age = mem_age;
		this.mem_email = mem_email;
		this.mem_img = mem_img;
		this.mem_detail = mem_detail;
	}

	public Sports_Member(String mem_id, String mem_pw, String mem_name, int mem_age, String mem_email) {
		super();
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_name = mem_name;
		this.mem_age = mem_age;
		this.mem_email = mem_email;
	}


	public int getMcnt() {
		return mcnt;
	}

	public void setMcnt(int mcnt) {
		this.mcnt = mcnt;
	}

	public String getMem_img() {
		return mem_img;
	}

	public void setMem_img(String mem_img) {
		this.mem_img = mem_img;
	}

	public String getMem_detail() {
		return mem_detail;
	}

	public void setMem_detail(String mem_detail) {
		this.mem_detail = mem_detail;
	}

	public String getLevel_name() {
		return level_name;
	}

	public void setLevel_name(String level_name) {
		this.level_name = level_name;
	}

	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public int getMem_age() {
		return mem_age;
	}
	public void setMem_age(int mem_age) {
		this.mem_age = mem_age;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	
	public String getCenter_name() {
		return center_name;
	}

	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}

	public int getMem_check() {
		return mem_check;
	}
	public void setMem_check(int mem_check) {
		this.mem_check = mem_check;
	}
	public int getSports_no() {
		return sports_no;
	}
	public void setSports_no(int sports_no) {
		this.sports_no = sports_no;
	}
	public int getLevel_no() {
		return level_no;
	}
	public void setLevel_no(int level_no) {
		this.level_no = level_no;
	}

	public String getMem_date() {
		return mem_date;
	}

	public void setMem_date(String mem_date) {
		this.mem_date = mem_date;
	}
	
}
