package com.ssg.study.study;

public class Study {
	private int listNum; // 나의 스터디 리스트에 뿌려줄 번호
	
	private int studyNum;
	private String studyName;
	private int studyStatus;
	private String studyGoal; // study 테이블
	
	private int role;
	private int memberNum; // 스터디멤버 역할 변경시 필요
	private String userId; // study_member 테이블
	
	private int boardNum;
	private String subject;
	private String content;
	private String reg_date;
	private String nickName;
	private int hitCount; // study_ad, study_ad_file 테이블
	
	private String updateDate; // 목표달성추가는 한번만 가능하도록 체크하는용도
	private int questCount; // times 테이블. 목표달성횟수에 따른 RANK 반영
	private int usedCount;  // times 테이블. 응모에 사용한 횟수
	private int rank;
	
	private int categoryNum; // 홈에서 카테고리별 리스트 불러올 때
	
	private String reason; // 스터디 신고할 때
	private int reportCount; // 관리자 스터디 리스트에서 신고당한 횟수 볼 때
	
	private String lottoDate; // 추첨일 선정 후 발표 할 때 마감일
	private int eventNum;
	private String eventCategory;
	private String prize;
	
	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public int getQuestCount() {
		return questCount;
	}

	public void setQuestCount(int questCount) {
		this.questCount = questCount;
	}

	public int getUsedCount() {
		return usedCount;
	}

	public void setUsedCount(int usedCount) {
		this.usedCount = usedCount;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

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

	public int getCategoryNum() {
		return categoryNum;
	}

	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}

	public String getLottoDate() {
		return lottoDate;
	}

	public void setLottoDate(String lottoDate) {
		this.lottoDate = lottoDate;
	}

	public int getEventNum() {
		return eventNum;
	}

	public void setEventNum(int eventNum) {
		this.eventNum = eventNum;
	}

	public String getEventCategory() {
		return eventCategory;
	}

	public void setEventCategory(String eventCategory) {
		this.eventCategory = eventCategory;
	}

	public String getPrize() {
		return prize;
	}

	public void setPrize(String prize) {
		this.prize = prize;
	}
}
