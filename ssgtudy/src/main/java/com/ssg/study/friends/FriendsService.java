package com.ssg.study.friends;

import java.util.List;
import java.util.Map;

public interface FriendsService {
	public List<Friends> readFriends(String userId);
	public List<Friends> readRegistrant(String userId);
	public List<Friends> readRegistered(String userId);
	public void insertFriends(Friends dto) throws Exception;
	public void deleteFriends(Friends dto) throws Exception;
	public void updateFriends(Friends dto) throws Exception;
	public List<Friends> readUserName(Map<String, Object> map) throws Exception;
}
