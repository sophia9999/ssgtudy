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
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("my.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
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
	public MyBoard myReadBoard(Map<String, Object> map) {
		MyBoard dto = null;
		
		try {
			dto = dao.selectOne("my.myReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<MyBoard> recList(Map<String, Object> map) {
		List<MyBoard> list = null;
		try {
			list = dao.selectList("my.recList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int recdataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("my.recdataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
