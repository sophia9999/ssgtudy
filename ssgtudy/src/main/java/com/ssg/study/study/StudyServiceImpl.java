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

	@Override
	public Study readStudy(Map<String, Object> map) throws Exception {
		Study dto = null;
		
		try {
			dto = dao.selectOne("study.readStudy", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public List<Map<String, Object>> readCategory(int studyNum) throws Exception {
		List<Map<String, Object>> list = null;
		
		try {
			list = dao.selectList("study.readCategory", studyNum);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int insertCategory(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("study.insertCategory", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateCategory(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateCategory", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteCategory(int categoryNum) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("study.deleteCategory", categoryNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int studyAdDataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("study.studyAdDataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> studyAdList(Map<String, Object> map) throws Exception {
		List<Study> list = null;
		
		try {
			list = dao.selectList("study.studyAdList", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public Study readStudyAd(int boardNum) throws Exception {
		Study dto = null;
		try {
			dto = dao.selectOne("study.readStudyAd", boardNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public int insertStudyAd(Study dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("study.insertStudyAd", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateStudyAd(Study dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateStudyAd", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteStudyAd(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("study.deleteStudyAd", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateStudyAdHitCount(int boardNum) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateStudyAdHitCount", boardNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int memberCount(Map<String, Object> paramMap) throws Exception {
		int result = 0;
		
		try {
			result = dao.selectOne("study.studyMemberOnce", paramMap);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int insertTimes(int studyNum) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("study.insertTimes", studyNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateQuestCount(int studyNum) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateQuestCount", studyNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateUsedCount(int studyNum) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateUsedCount", studyNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> rankList(Map<String, Object> map) throws Exception {
		List<Study> rankList = null;
		try {
			rankList = dao.selectList("study.rankList", map);
		} catch (Exception e) {
		}
		return rankList;
	}

	@Override
	public int rankDataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("study.rankDataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> memberList(int studyNum) throws Exception {
		List<Study> memberList = null;
		try {
			memberList = dao.selectList("study.memberList", studyNum);
		} catch (Exception e) {
		}
		return memberList;
	}

	@Override
	public int updateStudy(Study dto) throws Exception {
		int result = 0;
		try {
			dao.updateData("study.updateStudy", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int inactiveStudy(int studyNum) throws Exception {
		int result = 0;
		try {
			dao.updateData("study.inactiveStudy", studyNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> studyListByCategory(Map<String, Object> map) throws Exception {
		List<Study> listByCategory = null;
		try {
			listByCategory = dao.selectList("study.studyListByCategory", map);
		} catch (Exception e) {
		}
		return listByCategory;
	}

	@Override
	public int studyListByCategoryDataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			dao.selectOne("study.studyListByCategoryDataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

}
