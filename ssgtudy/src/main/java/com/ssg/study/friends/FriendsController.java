package com.ssg.study.friends;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.member.SessionInfo;

@Controller("friends.friendsController")
@RequestMapping(value="/friends/*")
public class FriendsController {
	
	@Autowired
	private FriendsService service;
	
	@RequestMapping(value="list")
	public String main( HttpSession session,
						Model model) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		List<Friends>friendslist = null;
		List<Friends>registrantlist = null;
		List<Friends>registeredlist = null;
		try {
			friendslist = service.readFriends(userId);
			registrantlist = service.readRegistrant(userId);
			registeredlist = service.readRegistered(userId);
		} catch (Exception e) {
		}
		
		model.addAttribute("friendslist",friendslist);
		model.addAttribute("registrantlist",registrantlist);
		model.addAttribute("registeredlist",registeredlist);
		
		return ".friends.list"; 
	}
	
	@RequestMapping(value="finduserName" ,method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> findUserName(String userName,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> val = new HashMap<String, Object>();
		List<Friends> list = null;
		try {			
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");	
			val.put("userName", userName);
			val.put("userId", info.getUserId());
			
			list = service.readUserName(val);
		} catch (Exception e) {
		}
		
		map.put("list", list);
		
		return map;
	}
	
	
	@RequestMapping(value="insertFriend" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertFriend(
			String friendId,
			HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "false";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member"); 
		Friends dto = null;
		try {
			dto = new Friends();
			dto.setRegistered(friendId);
			dto.setRegistrant(info.getUserId());
	
			service.insertFriends(dto);
			result = "true";
		} catch (Exception e) {
		}
		
		map.put("result", result);
		map.put("dto", dto);
		
		return map;
	}
	
	
	@RequestMapping(value="deleteFriend" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFriend(
			Friends dto,
			HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "false";
		
		try {
			
		
			service.deleteFriends(dto);
			result = "true";
		} catch (Exception e) {
		}
		
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="updateFriend" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateFriend(
			Friends dto,
			HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "false";
		 
		
		try {
			
			service.updateFriends(dto);
			result = "true";
		} catch (Exception e) {
		}
		
		map.put("result", result);
		
		return map;
	}

}
