package com.ssg.study.my;

import java.util.List;
import java.util.Map;

public interface MyService {
	// 내가쓴 글 리스트
	public int dataCount(Map<String, Object>map);
	public List<MyBoard> myList(Map<String, Object> map);
	public MyBoard myReadBoard(Map<String, Object> map);

	//내가 추천한 글 리스트
	public int recdataCount(Map<String, Object> map);
	public List<MyBoard> recList(Map<String, Object> map);
	
}
