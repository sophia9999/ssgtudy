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
	public int updateUsedCount(Map<String, Object> map) throws Exception;
	public Study questCountCheck(int studyNum) throws Exception;
	public Study readTimes(int studyNum) throws Exception;
	
	// 나의 스터디 리스트
	public List<Study> studyList(Map<String, Object> map) throws Exception;
	public int myStudyDataCount(String userId) throws Exception;
	
	// 스터디 홈
	public List<Study> studyHomeList(String userId) throws Exception;
	public Study readStudy(Map<String, Object> map) throws Exception;
	public Study visitStudy(int studyNum) throws Exception;
	public int deleteStudy(int studyNum) throws Exception;
	
	// 스터디 신고
	public int insertStudyReport(Map<String, Object> map) throws Exception;
	
	// 스터디 홈에서 멤버 리스트
	public List<Study> memberList(Map<String, Object> map) throws Exception;
	public int memberDataCount(Map<String, Object> paramMap) throws Exception;
	public int updateMember(Map<String, Object> map) throws Exception;
	public int deleteMember(int memberNum) throws Exception;
	
	// 스터디 홈 -> 카테고리 추가, 삭제, 등
	public List<Map<String, Object>> readCategory(int studyNum) throws Exception;
	public int insertCategory(Map<String, Object> map) throws Exception;
	public int updateCategory(Map<String, Object> map) throws Exception;
	public int deleteCategory(int categoryNum) throws Exception;
	
	// 스터디 홈에서 카테고리 별 리스트
	public List<Study> studyListByCategory(Map<String, Object> map) throws Exception; 
	public int studyListByCategoryDataCount(Map<String, Object> map) throws Exception;
	
	// 스터디 홈에서 해당 카테고리에 게시글
	public int insertEachStudyBoard(Study dto) throws Exception;
	public int updateHitCountByCategory(int boardNum) throws Exception;
	public Study readArticleByCategory(int boardNum) throws Exception;
	public int deleteEachStudyBoard(int boardNum) throws Exception;
	public int updateArticleByCategory(Study dto) throws Exception;
	
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
	
	// 스터디 관리자 페이지
	public int manageStudyDataCount(Map<String, Object> map) throws Exception;
	public List<Study> manageStudyList(Map<String, Object> map) throws Exception;
	public List<Study> reasonList(int studyNum) throws Exception;
	public int changeStudyStatus(Map<String, Object> map) throws Exception;
	
	// 이벤트
	public int insertEvent(Study dto) throws Exception;
	public int eventDataCount(Map<String, Object> map);
	public List<Study> eventList(Map<String, Object>map);
	public Study readEvent(int eventNum);
	public int updateEvent(Study dto) throws Exception;
	public int deleteEvent(int eventNum) throws Exception;
	
	// 이벤트 응모
	public int insertSoloEvent(Map<String, Object> map) throws Exception;
	public int insertStudyEvent(Map<String, Object> map) throws Exception;
	
	// 그룹응모용 불러오기
	public List<Study> eventStudyList(String userId) throws Exception;
	
	// 응모인원 불러오기
	public int soloEventDataCount(int eventNum);
	public int studyEventDataCount(int eventNum);
	
	// 당첨자 저장
	public int insertEventWinning(Map<String, Object> map) throws Exception;
	
	// 당첨자 뽑기
	public Study winning(Map<String, Object> map);
}
