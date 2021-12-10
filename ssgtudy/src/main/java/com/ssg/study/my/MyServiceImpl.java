package com.ssg.study.my;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service("my.myService")
public class MyServiceImpl implements MyService {

	@Override
	public List<My> myList(Map<String, Object> map) {
		return null;
	}

	@Override
	public int dataCount(String userId) {
		return 0;
	}

}
