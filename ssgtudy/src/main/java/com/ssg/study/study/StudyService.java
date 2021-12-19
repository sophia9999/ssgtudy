package com.ssg.study.study;

import java.util.List;
import java.util.Map;

public interface StudyService {
	// 스터디 등록, 수정, 비활성화
	public int selectStudyNum() throws Exception; 
	public int insertStudy(Study dto) throws Exception;
	public int insertStudyMember(Study dto) throws Exception;
	public int updateStudy(Study dto) throws Exception;
	public int inactiveStudy(int studyNum) throws Exception;
	
	// 스터디 등록시 스터디목표횟수 기록하는 테이블에도 같이 insert
	public int insertTimes(int studyNum) throws Exception;
	// 스터디 times 테이블
	public int updateQuestCount(int studyNum) throws Exception;
	public int updateUsedCount(int studyNum) throws Exception;
	
	// 나의 스터디 리스트
	public List<Study> studyList(Map<String, Object> map) throws Exception;
	public int myStudyDataCount(String userId) throws Exception;
	
	// 스터디 홈
	public List<Study> studyHomeList(String userId) throws Exception;
	public Study readStudy(Map<String, Object> map) throws Exception;
	public Study visitStudy(int studyNum) throws Exception;
	// 스터디 홈에서 멤버 리스트
	public List<Study> memberList(Map<String, Object> map) throws Exception;
	public int memberDataCount(int studyNum) throws Exception;
	
	// 스터디 홈 -> 카테고리 추가, 삭제, 등
	public List<Map<String, Object>> readCategory(int studyNum) throws Exception;
	public int insertCategory(Map<String, Object> map) throws Exception;
	public int updateCategory(Map<String, Object> map) throws Exception;
	public int deleteCategory(int categoryNum) throws Exception;
	
	// 스터디 홈에서 카테고리 별 리스트
	public List<Study> studyListByCategory(Map<String, Object> map) throws Exception; 
	public int studyListByCategoryDataCount(Map<String, Object> map) throws Exception;
	
	// 스터디 홍보 게시판
	public int studyAdDataCount(Map<String, Object> map) throws Exception;
	public List<Study> studyAdList(Map<String, Object> map) throws Exception;
	public Study readStudyAd(int boardNum) throws Exception;
	public int insertStudyAd(Study dto) throws Exception;
	public int updateStudyAd(Study dto) throws Exception;
	public int deleteStudyAd(Map<String, Object> map) throws Exception;
	public int updateStudyAdHitCount(int boardNum) throws Exception;
	public int memberCount(Map<String, Object> paramMap) throws Exception;
	
	// 스터디 랭크 게시판
	public int rankDataCount(Map<String, Object> map) throws Exception;
	public List<Study> rankList(Map<String, Object> map) throws Exception;
	
}
