package com.ssg.study.member;

// 세션에 저장할 정보(아이디, 이름, 권한 등)
public class SessionInfo {
	private String userId;
	private String userName;
	private String nickName;
	private int membership;
	private Integer schoolCode;
	private String schoolName;
	
	
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getMembership() {
		return membership;
	}

	public void setMembership(int membership) {
		this.membership = membership;
	}

	public Integer getSchoolCode() {
		return schoolCode;
	}

	public void setSchoolCode(Integer schoolCode) {
		this.schoolCode = schoolCode;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	
}
