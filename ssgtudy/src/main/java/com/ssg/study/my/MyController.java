package com.ssg.study.my;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssg.study.common.MyUtil;
import com.ssg.study.member.SessionInfo;

@Controller("my.myController")
@RequestMapping(value = "/my/*")
public class MyController {
	
	@Autowired
	private MyService service;
	
	@Autowired
	private MyUtil myUtil;
	
	// 리스트
	@RequestMapping(value = "list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		
		int rows = 5;
		int dataCount;
		int total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("userId", info.getUserId());
		map.put("start", start);
		map.put("end", end);
		
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}	
		List<MyBoard> list = service.myList(map);
		
		int listNum, n = 0;
		for (MyBoard dto : list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			n++;
		}
		
		String listUrl = cp + "/my/list";
		
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);		
		
		
		return ".my.list";
		}
	}
	

