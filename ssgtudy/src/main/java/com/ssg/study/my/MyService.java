package com.ssg.study.my;

import java.util.List;
import java.util.Map;

public interface MyService {
	public List<My> myList(Map<String, Object> map);
	
	public int dataCount(String userId);
}
