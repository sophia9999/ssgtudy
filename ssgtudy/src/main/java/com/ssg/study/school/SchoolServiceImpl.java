package com.ssg.study.school;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;
@Service("school.schoolService")
public class SchoolServiceImpl implements SchoolService{

	@Autowired
	CommonDAO dao;
	
	@Override
	public void insertSchool(School dto) throws Exception {
		try {
			dao.insertData("school.insertschool",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public School readSchool(Integer schoolCode) {
		School dto = null;
		try {
			dto = dao.selectOne("school.readSchool",schoolCode);
		} catch (Exception e) {
			e.printStackTrace();
		}		
				
		return dto;
	}

}
