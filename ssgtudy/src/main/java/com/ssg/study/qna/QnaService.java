package com.ssg.study.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {
	public void insertBoard(Qna dto, String pathname) throws Exception;
	public List<Qna> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Qna readBoard(int qnaNum);
	public void updateHitCount(int qnaNum) throws Exception;
	public Qna preReadBoard(Map<String, Object> map);
	public Qna nextReadBoard(Map<String, Object> map);
	public void updateBoard(Qna dto, String pathname) throws Exception;
	public void deleteBoard(int qnaNum, String pathname, String userId) throws Exception;

	public void insertFile(Qna dto) throws Exception;
	public List<Qna> listFile(int qnaNum);
	public Qna readFile(int qnafileNum);
	public void deleteFile(Map<String, Object> map)throws Exception;

	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public void deleteBoardLike(Map<String, Object> map) throws Exception;
	public int boardLikeCount(int qnaNum);
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
	public boolean userReplyLiked(Map<String, Object> map ) throws Exception;
	
	public int insertQnaReport(Map<String, Object> map) throws Exception;
	
	
}
