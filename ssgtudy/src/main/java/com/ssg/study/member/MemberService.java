package com.ssg.study.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member loginMember(String userId);
	public Member readMember(String userId);
	public List<Map<String, String>> readSchool();
	public void updateLastLogin(String userId) throws Exception;
	public void insertMember(Member dto) throws Exception;
}
