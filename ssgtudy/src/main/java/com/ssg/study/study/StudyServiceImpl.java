package com.ssg.study.study;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("study.studyService")
public class StudyServiceImpl implements StudyService {

	@Autowired
	private CommonDAO dao;

	@Override
	public int insertStudy(Study dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("study.insertStudy", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int selectStudyNum() throws Exception {
		int seq = 0;
		try {
			seq = dao.selectOne("study.seq");

		} catch (Exception e) {
		}

		return seq;
	}

	@Override
	public int insertStudyMember(Study dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("study.insertStudyMember", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> studyList(Map<String, Object> map) throws Exception {
		List<Study> list = null;
		
		try {
			list = dao.selectList("study.studyList", map);
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public int myStudyDataCount(String userId) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("study.myStudyDataCount", userId);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Study> studyHomeList(String userId) throws Exception {
		List<Study> list= null;
		
		try {
			list = dao.selectList("study.studyHomeList", userId);
		} catch (Exception e) {
		}
		return list;
	}

}
