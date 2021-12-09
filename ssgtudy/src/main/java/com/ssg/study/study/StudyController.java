package com.ssg.study.study;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssg.study.common.MyUtil;
import com.ssg.study.member.SessionInfo;

@Controller("Study.studyController")
@RequestMapping("/study/*")
public class StudyController {
	
	@Autowired
	private StudyService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "list")
	public String studyList(Model model, 
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req
			) throws Exception {
		Map<String, Object> map = new Hashtable<String, Object>();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
			
		dataCount = service.myStudyDataCount(userId);
		map.put("userId", userId);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = (current_page * rows);
		map.put("start", start);
		map.put("end", end);
		
		List<Study> list = service.studyList(map);
		
		int listNum, n = 0;
		for(Study dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String listUrl = cp + "/study/list";
		String articleUrl = cp + "/study/home";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("total_page", total_page);
		
		
		return ".study.list";
	}
	
	@RequestMapping(value = "enroll", method = RequestMethod.GET)
	public String writeForm() throws Exception {
		return ".study.write";
	}
	
	@RequestMapping(value = "enroll", method = RequestMethod.POST)
	public String writeSubmit(Study dto,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if( info == null) {
			return "redirect:/member/login";
		}
		
		dto.setUserId(info.getUserId());
		dto.setRole(20); // 생성자 - 스터디장 설정
		
		try {
			int seq = service.selectStudyNum(); // 시퀀스에서 StudyNum 가져옴
			dto.setStudyNum(seq);
			
			service.insertStudy(dto); // study 테이블 삽입
			service.insertStudyMember(dto); // study_member 테이블 삽입
			
		} catch (Exception e) {
		}
		
		return "redirect:/study/list";
	}
	
	@RequestMapping(value = "home/{studyNum}")
	public String studyHome(
			@PathVariable int studyNum,
			HttpSession session,
			Model model	) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Study dto = null;
		
		for(Study vo : service.studyHomeList(userId)) {
			if(vo.getStudyNum() == studyNum) {
				dto = vo;
				break;
			}
		}
		
		model.addAttribute("dto", dto);
		
		return ".study.home";
	}
	
	@RequestMapping(value = "addCategory", method = RequestMethod.GET)
	public String addCategory(Model model) throws Exception {
		return "";
	}
}
