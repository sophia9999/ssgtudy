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
	public List<Member> readStateCode() {
		List<Member> list = null;
		try {
			list = dao.selectList("member.readStateCode");
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

}
