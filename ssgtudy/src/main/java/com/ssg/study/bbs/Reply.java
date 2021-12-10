package com.ssg.study.bbs;

public class Reply {
	private int replyNum;
	private String userId;
	private String userName;
	private String content;
	private String reg_date;
	private int parentReplyNum;
	private String reason;
	
	
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public int getParentReplyNum() {
		return parentReplyNum;
	}
	public void setParentReplyNum(int parentReplyNum) {
		this.parentReplyNum = parentReplyNum;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
}
