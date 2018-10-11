package com.bybogon.sports.vo;

public class Sports_Brd {
	private int brd_no = 0;
	private String brd_content = null;
	private String brd_writer = null;
	private String brd_date = null;
	private int brd_group = 0;
	private String brd_img = null;
	
	private String mem_name = null;
	private String mem_img = null;
	
	public Sports_Brd() {
		super();
	}
	
	public Sports_Brd(String brd_content, String brd_writer, int brd_group, String brd_img) {
		super();
		this.brd_content = brd_content;
		this.brd_writer = brd_writer;
		this.brd_group = brd_group;
		this.brd_img = brd_img;
	}
	
	public Sports_Brd(String brd_content, String brd_writer, int brd_group) {
		super();
		this.brd_content = brd_content;
		this.brd_writer = brd_writer;
		this.brd_group = brd_group;
	}

	
	
	public String getMem_img() {
		return mem_img;
	}

	public void setMem_img(String mem_img) {
		this.mem_img = mem_img;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public int getBrd_no() {
		return brd_no;
	}
	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public String getBrd_writer() {
		return brd_writer;
	}
	public void setBrd_writer(String brd_writer) {
		this.brd_writer = brd_writer;
	}
	public String getBrd_date() {
		return brd_date;
	}
	public void setBrd_date(String brd_date) {
		this.brd_date = brd_date;
	}
	public int getBrd_group() {
		return brd_group;
	}
	public void setBrd_group(int brd_group) {
		this.brd_group = brd_group;
	}

	public String getBrd_img() {
		return brd_img;
	}
	public void setBrd_img(String brd_img) {
		this.brd_img = brd_img;
	}
	
}
