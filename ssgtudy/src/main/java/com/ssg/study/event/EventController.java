package com.ssg.study.event;

import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.MyUtil;
import com.ssg.study.member.Member;
import com.ssg.study.member.MemberService;
import com.ssg.study.member.SessionInfo;
import com.ssg.study.study.Study;
import com.ssg.study.study.StudyService;

@Controller("Event.eventController")
@RequestMapping("/event/*")
public class EventController {

	@Autowired
	private StudyService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("list")
	public String lottoList(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "condition") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return "redirect:/member/login";
		}
		
		String cp = req.getContextPath();
		
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.eventDataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Study> list = service.eventList(map);
		
		// 리스트의 번호
		int listNum, n = 0;
		for (Study dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/studyManage/lotto";
		String articleUrl = cp + "/event/article?page="+current_page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "&" + query;
			articleUrl += "&" +query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".event.lottolist";
	}
	
	@RequestMapping(value = "article")
	public String readArticle(
			@RequestParam int eventNum, 
			@RequestParam String page,
			@RequestParam(defaultValue = "condition") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpSession session) throws Exception {
		
		String query = "?page="+page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		Study dto = service.readEvent(eventNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".event.article";
	}

	// AJAX - JSON 개인 이벤트 응모
	@RequestMapping(value = "apply")
	@ResponseBody
	public Map<String, Object> applyLotto(
			@RequestParam int eventNum,
			HttpSession session,
			@RequestParam int needPoint
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> model = new HashMap<String, Object>();

		String status = "true";
		
		if(info == null) {
			status = "403";
			model.put("status", status);
			return model;
		}
		
		String userId = info.getUserId();
		Member MemberVO = null;
		MemberVO = memberService.readMember(userId);
		
		if(MemberVO.getQuestCount() - MemberVO.getLottoUse() < needPoint) {
			model.put("status", "needMore");
			return model;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("eventNum", eventNum);
		int result = 0;
		try {			
			result = service.insertSoloEvent(paramMap);
			if(result == 0) { // 이미 응모한 이벤트일 경우
				status = "duplication";
				model.put("status", status);
				return model;
			}
			
			paramMap.clear();
			paramMap.put("userId", userId);
			paramMap.put("lottoUse", needPoint);
			memberService.updateUsedCount(paramMap);
		} catch (Exception e) {
		}	
		
		model.put("status", status);
		
		return model;
	}
	
	@RequestMapping(value = "readStudy")
	@ResponseBody
	public Map<String, Object> readStudy(HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		String status = "true";
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		List<Study> studyList = null;
		studyList = service.eventStudyList(userId);
		
		if(studyList == null) {
			status = "false";
			model.put("status", status);
			return model;
		}
		
		model.put("studyList", studyList);
		model.put("status", status);
		return model;
	}
	
	// AJAX - JSON 스터디 응모
	@RequestMapping(value = "studyEventApply")
	@ResponseBody
	public Map<String, Object> studyEventApply(
			@RequestParam int eventNum,
			@RequestParam int needPoint,
			@RequestParam int studyNum,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> model = new HashMap<String, Object>();

		String status = "true";
		
		if(info == null) {
			status = "403";
			model.put("status", status);
			return model;
		}
		
		Study VO = service.readTimes(studyNum);
		
		if(VO.getQuestCount() - VO.getUsedCount() < needPoint) {
			model.put("status", "needMore");
			return model;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("studyNum", studyNum);
		paramMap.put("eventNum", eventNum);
		int result = 0;
		try {			
			result = service.insertStudyEvent(paramMap);
			if(result == 0) { // 이미 응모한 이벤트일 경우
				status = "duplication";
				model.put("status", status);
				return model;
			}
			
			paramMap.clear();
			paramMap.put("studyNum", studyNum);
			paramMap.put("usedCount", needPoint);
			service.updateUsedCount(paramMap);
		} catch (Exception e) {
		}	
		
		model.put("status", status);
		
		return model;
	}
	
}
