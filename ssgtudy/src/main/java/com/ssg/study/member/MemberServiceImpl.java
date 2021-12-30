package com.ssg.study.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("member.service")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private CommonDAO dao; 

	@Override
	public Member loginMember(String userId) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		
		try {
			dao.insertData("member.insertMember", dto);
			dao.insertData("member.insertMember_detail", dto);
		} catch (Exception e) {		
		}
		
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Map<String, String>> readSchool() {
		List<Map<String, String>> list = null;
		try {
			  list = dao.selectList("member.readSchool");
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public Member readMember(String userId) {
		Member dto = null;
		try {
			dto = dao.selectOne("member.readuserId", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			dao.insertData("member.updatemember", dto);
			dao.insertData("member.updatemember_detail", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Member> readAdmin() {
		List<Member> list = null;
		try {
			list = dao.selectList("member.readAdmin");
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public Member findAdmin(String userId) {
		Member dto = null;
		try {
			dto = dao.selectOne("member.findAdmin",userId);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateAdmin(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateAdmin", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Member> readStateCode(Map<String, Object> map) {
		List<Member> list = null;
		try {
			list = dao.selectList("member.readStateCode",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateStateCode(Map<String, Object> map) throws Exception {
		try {
			 dao.updateData("member.updateStateCode",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Integer readCnt(String keword) {
		Integer cnt = 0;
		
		try {
			cnt = dao.selectOne("member.readCount",keword);
		} catch (Exception e) {
		}
		
		return cnt;
	}

	@Override
	public List<Reportmember> readCommuity(Map<String, Object> map) {
		List<Reportmember> list = null;
		try {
			list = dao.selectList("member.readcommunity",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Reportmember> readlist(Map<String, Object> map) {
		List<Reportmember> list = null;
		try {
			list = dao.selectList("member.readlist",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Reportmember> readqna(Map<String, Object> map) {
		List<Reportmember> list = null;
		try {
			list = dao.selectList("member.readqna",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteReport(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("member.deleteReport", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Integer readCommCnt() {
		Integer cnt = 0;
		try {
			cnt = dao.selectOne("member.dataCountReportComm");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public Integer readlistCnt() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer readQnaCnt() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateQuestCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("member.updateQuestCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int updateUsedCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("member.updateUsedCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public void updateFailurecnt(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updatefailurecnt", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
