package com.jbedu.member.dto;

public class MemberDto {

	private String memberid;
	private String memberpw;
	private String membername;
	private String memberemail;
	private int memberage;
	
	public MemberDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberDto(String memberid, String memberpw, String membername, String memberemail, int memberage) {
		super();
		this.memberid = memberid;
		this.memberpw = memberpw;
		this.membername = membername;
		this.memberemail = memberemail;
		this.memberage = memberage;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getMemberpw() {
		return memberpw;
	}

	public void setMemberpw(String memberpw) {
		this.memberpw = memberpw;
	}

	public String getMembername() {
		return membername;
	}

	public void setMembername(String membername) {
		this.membername = membername;
	}

	public String getMemberemail() {
		return memberemail;
	}

	public void setMemberemail(String memberemail) {
		this.memberemail = memberemail;
	}

	public int getMemberage() {
		return memberage;
	}

	public void setMemberage(int memberage) {
		this.memberage = memberage;
	}
	
	
}
