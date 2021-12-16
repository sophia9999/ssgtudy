package com.ssg.study.friends;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("friends.friendsServicImpl")
public class FriendsServiceImpl implements FriendsService{
	
	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public List<Friends> readFriends(String userId) {
		List<Friends> list =null;
		try {
			list = dao.selectList("friends.friendslist",userId);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public List<Friends> readRegistrant(String userId) {
		List<Friends> list =null;
		try {
			list = dao.selectList("friends.registrantlist",userId);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public List<Friends> readRegistered(String userId) {
		List<Friends> list =null;
		try {
			list = dao.selectList("friends.registeredlist",userId);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public void insertFriends(Friends dto) throws Exception {
		try {
			dao.insertData("friends.insertFriend", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}


	@Override
	public List<Friends> readUserName(String userName) throws Exception {
		List<Friends> list =null;
		try {
			list = dao.selectList("friends.readUserName",userName);
		} catch (Exception e) {
		}
		return list;		
	}

	@Override
	public void deleteFriends(Friends dto) throws Exception {
		try {
			dao.deleteData("friends.deleteFriends", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void updateFriends(Friends dto) throws Exception {
		try {
			dao.updateData("friends.updateregistered", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

}
