package com.ssg.study.school;

public interface SchoolService {
	public void insertSchool(School dto) throws Exception;
	public School readSchool(Integer schoolCode);
}
