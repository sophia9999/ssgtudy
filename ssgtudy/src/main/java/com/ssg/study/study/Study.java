package com.ssg.study.study;

public class Study {
	private int listNum; // 나의 스터디 리스트에 뿌려줄 번호
	
	private int studyNum;
	private String studyName;
	private int studyStatus;
	private String studyGoal; // study 테이블
	
	private int role;
	private int memberNum; 
	private String userId; // study_member 테이블
	
	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public int getMemberNum() {
		return memberNum;
	}

	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getStudyNum() {
		return studyNum;
	}

	public void setStudyNum(int studyNum) {
		this.studyNum = studyNum;
	}

	public String getStudyName() {
		return studyName;
	}

	public void setStudyName(String studyName) {
		this.studyName = studyName;
	}

	public String getStudyGoal() {
		return studyGoal;
	}

	public void setStudyGoal(String studyGoal) {
		this.studyGoal = studyGoal;
	}

	public int getStudyStatus() {
		return studyStatus;
	}

	public void setStudyStatus(int studyStatus) {
		this.studyStatus = studyStatus;
	}
}
