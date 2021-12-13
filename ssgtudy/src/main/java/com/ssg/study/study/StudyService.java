package com.ssg.study.study;

import java.util.List;
import java.util.Map;

public interface StudyService {
	// 스터디 등록
	public int selectStudyNum() throws Exception; 
	public int insertStudy(Study dto) throws Exception;
	public int insertStudyMember(Study dto) throws Exception; 
	
	// 나의 스터디 리스트
	public List<Study> studyList(Map<String, Object> map) throws Exception;
	public int myStudyDataCount(String userId) throws Exception;
	
	// 스터디 홈
	public List<Study> studyHomeList(String userId) throws Exception;
	public Study readStudy(Map<String, Object> map) throws Exception;
	
	// 스터디 홈 -> 카테고리 추가, 삭제, 등
	public List<Map<String, Object>> readCategory(int studyNum) throws Exception;
	public int insertCategory(Map<String, Object> map) throws Exception;
	public int updateCategory(Map<String, Object> map) throws Exception;
	public int deleteCategory(int categoryNum) throws Exception;
	
	// 스터디 홍보 게시판
	public int studyAdDataCount(Map<String, Object> map) throws Exception;
	public List<Study> studyAdList(Map<String, Object> map) throws Exception;
	public Study readStudyAd(int boardNum) throws Exception;
	public int insertStudyAd(Study dto) throws Exception;
	public int updateStudyAd(Study dto) throws Exception;
	public int deleteStudyAd(Map<String, Object> map) throws Exception;
	
	
}
