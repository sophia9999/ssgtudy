package com.ssg.study;

import java.util.HashMap;


import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssg.study.friends.Friends;
import com.ssg.study.friends.FriendsService;
import com.ssg.study.member.SessionInfo;
import com.ssg.study.notice.Notice;
import com.ssg.study.notice.NoticeService;
import com.ssg.study.study.Study;
import com.ssg.study.study.StudyService;



@Controller
public class HomeController {
@Autowired
private FriendsService fservice;

@Autowired
private StudyService sservice; 

@Autowired
private NoticeService nservice;
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String homeFriends(
			Locale locale,
			Model ml,
			HttpSession session) {
		List<Friends> flist = null;
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");		
		try {
			flist = fservice.readFriends(info.getUserId());
			
			ml.addAttribute("friendslist", flist);
			
		} catch (Exception e) {
		}
			
		List<Study> rlist = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			rlist = sservice.rankList(map);
			
			ml.addAttribute("ranklist", rlist);
		} catch (Exception e) {
		}
		
		map.put("start", 0);
		map.put("end", 5);
		map.put("keyword", "");
		
		List<Study> adlist = null;
		//Map<String, Object> map = new HashMap<String, Object>();
		
		
		try {
			adlist = sservice.studyAdList(map);
			
			ml.addAttribute("adlist", adlist);
			
		} catch (Exception e) {
		}
		
		
		List<Notice> nlist = null;
		//Map<String, Object> map = new HashMap<String, Object>();
		try {
			nlist = nservice.listBoard(map);
			
			ml.addAttribute("noticelist", nlist);
		} catch (Exception e) {
		}
	
		int count = 1;
		
		
		for(Notice n : nlist) {
			n.setListNum(count++);
		}
			
		return ".home";
	}	
}
