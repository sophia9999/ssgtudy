package com.ssg.study.study;

import java.util.List;
import java.util.Map;

public interface StudyService {
	public int selectStudyNum() throws Exception;
	public int insertStudy(Study dto) throws Exception;
	public int insertStudyMember(Study dto) throws Exception;
	public List<Study> studyList(Map<String, Object> map) throws Exception;
	public int myStudyDataCount(String userId) throws Exception;
	public List<Study> studyHomeList(String userId) throws Exception;
}
