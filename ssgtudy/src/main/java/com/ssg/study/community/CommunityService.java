package com.ssg.study.community;

import java.util.List;
import java.util.Map;

public interface CommunityService {
	public void insertBoard(Community dto, String pathname) throws Exception;
	
	public List<Community> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public Community readBoard(int boardNum);
	public void updateHitCount(int boardNum) throws Exception;
	public Community preReadBoard(Map<String, Object> map);
	public Community nextReadBoard(Map<String, Object> map);
	
	public void updateBoard(Community dto, String pathname) throws Exception;
	public void deleteBoard(int boardNum, String pathname, String userId, int membership) throws Exception;
	public void deleteBoardList(List<String> chkRow, String pathname, String userId, int membership) throws Exception;
	
	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public void deleteBoardLike(Map<String, Object> map) throws Exception;
	public int boardLikeCount(int boardNum);
	public boolean userBoardLiked(Map<String, Object> map);
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public void deleteReplyLike(Map<String, Object> map) throws Exception;
	public int replyLikeCount(int replyNum);
	public boolean userReplyLiked(Map<String, Object> map) throws Exception;
	
	public void insertFile(Community dto) throws Exception;
	public List<Community> listFile(int boardNum);
	public Community readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	public void insertBoardReport(Community dto) throws Exception;
	public void insertReplyReport(Reply dto) throws Exception;
}
