package com.ssg.study.todo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Todo {
	private int listNum;
	
	private int todoNum;
	private String subject;
	private String content;
	private String reg_date;
	
	private String userId;
	
	private int todo_fileNum;
	private int originalFilename;
	private int saveFilename;
	private long fileSize;
	private List<MultipartFile> selectFile;
	private long gap;
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getTodoNum() {
		return todoNum;
	}
	public void setTodoNum(int todoNum) {
		this.todoNum = todoNum;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getTodo_fileNum() {
		return todo_fileNum;
	}
	public void setTodo_fileNum(int todo_fileNum) {
		this.todo_fileNum = todo_fileNum;
	}
	public int getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(int originalFilename) {
		this.originalFilename = originalFilename;
	}
	public int getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(int saveFilename) {
		this.saveFilename = saveFilename;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public List<MultipartFile> getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(List<MultipartFile> selectFile) {
		this.selectFile = selectFile;
	}
	public long getGap() {
		return gap;
	}
	public void setGap(long gap) {
		this.gap = gap;
	}
	
	
	
	

}
