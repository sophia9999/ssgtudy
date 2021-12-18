package com.ssg.study.note;

import java.util.List;

public class Note {
	private int noteNum;			//쪽지번호
	private String content;			//내용
	private String sendDay;			// 보낸날짜
	private String identifyDay;		// 확인날짜
	private String receiveDelete;	// 받은사람쪽지삭제여부
	private String sendDelete;		// 보낸사람 쪽지삭제여
	private String senderId;		// 보낸유저
	private String receiverId;		// 받은유저
	private String senderNickName;
	private String receiverNickName;
	
	private String userName;
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	private List<String> receivers;
	private String userId;
	private String nickName;

	public String getSenderNickName() {
		return senderNickName;
	}

	public void setSenderNickName(String senderNickName) {
		this.senderNickName = senderNickName;
	}

	public String getReceiverNickName() {
		return receiverNickName;
	}

	public void setReceiverNickName(String receiverNickName) {
		this.receiverNickName = receiverNickName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getNoteNum() {
		return noteNum;
	}

	public void setNoteNum(int noteNum) {
		this.noteNum = noteNum;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSendDay() {
		return sendDay;
	}

	public void setSendDay(String sendDay) {
		this.sendDay = sendDay;
	}

	public String getIdentifyDay() {
		return identifyDay;
	}

	public void setIdentifyDay(String identifyDay) {
		this.identifyDay = identifyDay;
	}

	public String getReceiveDelete() {
		return receiveDelete;
	}

	public void setReceiveDelete(String receiveDelete) {
		this.receiveDelete = receiveDelete;
	}

	public String getSendDelete() {
		return sendDelete;
	}

	public void setSendDelete(String sendDelete) {
		this.sendDelete = sendDelete;
	}

	public String getSenderId() {
		return senderId;
	}

	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public List<String> getReceivers() {
		return receivers;
	}

	public void setReceivers(List<String> receivers) {
		this.receivers = receivers;
	}

}
