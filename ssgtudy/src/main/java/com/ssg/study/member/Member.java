package com.ssg.study.member;

public class Member {
	//member
	private String userId;
	private String pwd;
	private int stateCode;
	private String join_date;
	private String edit_date;
	private String last_date;
	private int failure_cnt;
	
	// member_detail
	private String nickName;
	private String tel;
	private String membership;
	private String birth;
	private String email;
	private String zip_code;
	private String addr1;
	private String addr2;
	private int SchoolCode;
	private int codeChange_cnt;
	private int questCount;
	private int lottoUse;
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getStateCode() {
		return stateCode;
	}
	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public String getEdit_date() {
		return edit_date;
	}
	public void setEdit_date(String edit_date) {
		this.edit_date = edit_date;
	}
	public String getLast_date() {
		return last_date;
	}
	public void setLast_date(String last_date) {
		this.last_date = last_date;
	}
	public int getFailure_cnt() {
		return failure_cnt;
	}
	public void setFailure_cnt(int failure_cnt) {
		this.failure_cnt = failure_cnt;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMembership() {
		return membership;
	}
	public void setMembership(String membership) {
		this.membership = membership;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public int getSchoolCode() {
		return SchoolCode;
	}
	public void setSchoolCode(int schoolCode) {
		SchoolCode = schoolCode;
	}
	public int getCodeChange_cnt() {
		return codeChange_cnt;
	}
	public void setCodeChange_cnt(int codeChange_cnt) {
		this.codeChange_cnt = codeChange_cnt;
	}
	public int getQuestCount() {
		return questCount;
	}
	public void setQuestCount(int questCount) {
		this.questCount = questCount;
	}
	public int getLottoUse() {
		return lottoUse;
	}
	public void setLottoUse(int lottoUse) {
		this.lottoUse = lottoUse;
	}
	
		
	
}
