package com.ssg.study.bbs;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public void insertBoard(Board dto, String pathname) throws Exception;
	public List<Board> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Board readBoard(int bbsNum);
	public void updateHitCount(int bbsNum) throws Exception;
	public Board preReadBoard(Map<String, Object> map);
	public Board nextReadBoard(Map<String, Object> map);
	public void updateBoard(Board dto, String pathname) throws Exception;
	public void deleteBoard(int bbsNum, String pathname, String userId) throws Exception;

	public void insertFile(Board dto) throws Exception;
	public List<Board> listFile(int bbsNum);
	public Board readFile(int bbs_fileNum);
	public void deleteFile(Map<String, Object> map)throws Exception;

	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public void deleteBoardLike(Map<String, Object> map) throws Exception;
	public int boardLikeCount(int bbsNum);
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
	
	public int insertBbsReport(Map<String, Object> map) throws Exception;
	
}
