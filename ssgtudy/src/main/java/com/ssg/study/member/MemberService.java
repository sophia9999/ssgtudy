package com.ssg.study.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member loginMember(String userId);
	public Member readMember(String userId);
	public Member findAdmin(String userId);
	public List<Map<String, String>> readSchool();
	public List<Member> readAdmin();
	public void updateLastLogin(String userId) throws Exception;
	public void insertMember(Member dto) throws Exception;
	public void updateMember(Member dto) throws Exception;
	public void updateAdmin(Map<String, Object> map) throws Exception;
	public List<Member> readStateCode(Map<String, Object> map);
	public void updateStateCode(Map<String, Object> map) throws Exception;
	public Integer readCnt(String keword);
}
