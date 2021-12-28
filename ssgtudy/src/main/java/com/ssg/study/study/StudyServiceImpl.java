package com.ssg.study.study;

import java.util.Comparator;
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
			result += insertStudyMember(dto);
			result += insertTimes(dto.getStudyNum());
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
	public int updateUsedCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateUsedCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> rankList(Map<String, Object> map) throws Exception {
		List<Study> rankList = null;
		String keyword = (String)map.get("keyword");
		try {
			rankList = dao.selectList("study.rankList", map);
			
			// 검색했으면, 검색한 것에 해당하는 것들만 나오도록
			
			rankList.sort(new rankComparator() ); // questCount 수에 따른 오름차순 정렬
			
			// 오름차순 정렬되있으므로 순위를 매겨준다.
			int rank = 1;
			for(int i = 0; i < rankList.size(); i++) {
				rankList.get(i).setRank(rank++);
			}
			
			// 검색에 부합하는 것들만 나옴
			if(keyword != null && keyword != "") {
				int size = rankList.size();
				for(int i = 0; i < size; i++) {
					String studyName = rankList.get(i).getStudyName();

					// System.out.println(studyName);
					
					if (! studyName.contains(keyword)) { // 키워드없으면 지워라
						rankList.remove(i);
						size = rankList.size(); // 지우면 리스트의 사이즈가 바뀌므로 다시설정해준다.
						i--;
					}
				}			
			}
			
			
		} catch (Exception e) {
		}
		return rankList;
	}
	
	class rankComparator implements Comparator<Study> {
		int n = 1;

		@Override
		public int compare(Study o1, Study o2) {
			if(o1.getQuestCount() > o2.getQuestCount() ) {
				return -1;
			} else if(o1.getQuestCount() < o2.getQuestCount()) {
				return 1;
			}
			return 0;
		}	
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
	public List<Study> memberList(Map<String, Object> map) throws Exception {
		List<Study> memberList = null;
		try {
			memberList = dao.selectList("study.memberList", map);
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
			result = dao.selectOne("study.studyListByCategoryDataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Study visitStudy(int studyNum) throws Exception {
		Study dto = null;
		try {
			dto = dao.selectOne("study.visitStudy", studyNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public int memberDataCount(Map<String, Object> paramMap) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("study.memberDataCount", paramMap);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateMember(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateMember", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteMember(int memberNum) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("study.deleteMember", memberNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Study questCountCheck(int studyNum) throws Exception {
		Study dto = null;
		try {
			dto = dao.selectOne("study.questCountCheck", studyNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public int insertStudyReport(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("study.insertStudyReport", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int insertEachStudyBoard(Study dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("study.insertEachStudyBoard", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Study readArticleByCategory(int boardNum) throws Exception {
		Study dto = null;
		try {
			dto = dao.selectOne("study.readArticleByCategory", boardNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public int updateHitCountByCategory(int boardNum) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateHitCountByCategory", boardNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteEachStudyBoard(int boardNum) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("study.deleteEachStudyBoard", boardNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateArticleByCategory(Study dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.updateArticleByCategory", dto);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int deleteStudy(int studyNum) throws Exception {
		int result=0;
		try {
			result = dao.deleteData("study.deleteStudy", studyNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> manageStudyList(Map<String, Object> map) throws Exception {
		List<Study> list = null;
		try {
			list = dao.selectList("study.manageStudyList", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int manageStudyDataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("study.manageStudyDataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Study> reasonList(int studyNum) throws Exception {
		List<Study> list = null;
		try {
			list = dao.selectList("study.reasonList", studyNum);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int changeStudyStatus(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("study.changeStudyStatus", map);
		} catch (Exception e) {
		}
		return result;
	}
	
	

}
