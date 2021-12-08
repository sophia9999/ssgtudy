package com.ssg.study.member;

public interface MemberService {
	public Member loginMember(String userId);
	public void updateLastLogin(String userId) throws Exception;
	public void insertMember(Member dto) throws Exception;
}
