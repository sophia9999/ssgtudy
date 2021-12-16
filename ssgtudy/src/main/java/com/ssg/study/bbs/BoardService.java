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
}
