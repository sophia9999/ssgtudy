package com.ssg.study.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public void insertBoard(Notice dto, String pathname) throws Exception;
	public List<Notice> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Notice readBoard(int nNum);
	public void updateHitCount(int nNum) throws Exception;
	public Notice preReadBoard(Map<String, Object> map);
	public Notice nextReadBoard(Map<String, Object> map);
	public void updateBoard(Notice dto, String pathname) throws Exception;
	public void deleteBoard(int nNum, String pathname, String userId) throws Exception;

	public void insertFile(Notice dto) throws Exception;
	public List<Notice> listFile(int nNum);
	public Notice readFile(int notice_fileNum);
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
