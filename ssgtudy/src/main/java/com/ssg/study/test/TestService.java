package com.ssg.study.test;

import java.util.List;
import java.util.Map;

public interface TestService {
	public void insertBoard(Mock dto, String pathname) throws Exception;
	public List<Mock> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Mock readBoard(int testNum);
	public void updateHitCount(int testNum) throws Exception;
	public Mock preReadBoard(Map<String, Object> map);
	public Mock nextReadBoard(Map<String, Object> map);
	public void updateBoard(Mock dto, String pathname) throws Exception;
	public void deleteBoard(int testNum, String pathname, String userId) throws Exception;

	public void insertFile(Mock dto) throws Exception;
	public List<Mock> listFile(int testNum);
	public Mock readFile(int test_fileNum);
	public void deleteFile(Map<String, Object> map)throws Exception;
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public void deleteReplyLike(Map<String, Object> map) throws Exception;
	public int replyLikeCount(int replyNum);
	public boolean userReplyLiked(Map<String, Object> map ) throws Exception;
	
	
}
