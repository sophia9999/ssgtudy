package com.ssg.study.member;

public interface MemberService {
	public Member loginMember(String userId);
	
	public void insertMember(Member dto) throws Exception;
}
