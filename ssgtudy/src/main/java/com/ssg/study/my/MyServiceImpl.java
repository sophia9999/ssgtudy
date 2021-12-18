package com.ssg.study.my;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("my.myService")
public class MyServiceImpl implements MyService {

	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public List<MyBoard> myList(Map<String, Object> map) {
		List<MyBoard> list = null;
		
		try {
			list = dao.selectList("my.myList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("my.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
}
