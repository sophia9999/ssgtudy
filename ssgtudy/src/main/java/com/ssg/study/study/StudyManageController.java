package com.ssg.study.study;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.MyUtil;
import com.ssg.study.member.SessionInfo;

@Controller("study.studyManageController")
@RequestMapping("/studyManage/*")
public class StudyManageController {
	
	@Autowired
	private StudyService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "all")
	public String managelist(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "studyName") String condition,
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
		
		if(condition.equalsIgnoreCase("inactive")) {
			map.put("onlyInactive", "yes");
		}
		
		dataCount = service.manageStudyDataCount(map);
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
		
		List<Study> list = service.manageStudyList(map);
		
		// 리스트의 번호
		int listNum, n = 0;
		for (Study dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/studyManage/all";
		String articleUrl = cp + "/study/home/";
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "&" + query;
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
		
		
		return ".admin.studyManage.managelist";
	}
	
	// AJAX - JSON 신고사유리스트 불러오기
	@RequestMapping(value = "reasonList")
	@ResponseBody
	public Map<String, Object> reasonList(
			@RequestParam int studyNum) throws Exception {
		
		List<Study> reasonList = service.reasonList(studyNum);
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("reasonList", reasonList);
		
		return model;
	}
	
	// AJAX - JSON 스터디상태변경하기
	@RequestMapping(value = "changeStatus")
	@ResponseBody
	public Map<String, Object> changeStatus(
			@RequestParam int studyNum,
			@RequestParam int studyStatus,
			HttpSession session) throws Exception {
		String status = "true";
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		if(info == null) {
			status = "403";
			model.put("status", status);
			return model;
		} else if (info.getMembership() < 50) {
			status = "403";
			model.put("status", status);
			return model;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studyNum", studyNum);
		map.put("studyStatus", studyStatus);
		
		service.changeStudyStatus(map);
		
		model.put("status", status);
		
		return model;
	}
	
	@RequestMapping(value = "lotto")
	public String lottoStudy(
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
		
		int rows = 2; // 한 화면에 보여주는 게시물 수
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
		
		return ".admin.studyManage.lottolist";
	}
	
	@RequestMapping(value = "event/write", method = RequestMethod.GET)
	public String lottoWriteForm(Model model) throws Exception {

		model.addAttribute("mode", "write");
		
		return ".admin.studyManage.lottowrite";
	}
	
	@RequestMapping(value = "event/write", method = RequestMethod.POST)
	public String lottoWriteSubmit(Study dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return "redirect:/member/login";
		}
		
		if(dto.getNeedPoint() == null) {
			dto.setNeedPoint(0);
		}
		
		service.insertEvent(dto);
		
		return "redirect:/studyManage/lotto";
	}
	
	
	@RequestMapping(value = "event/update", method = RequestMethod.GET)
	public String updateForm(
			int eventNum,
			Model model,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return "redirect:/member/login";
		}
		
		if(info.getMembership() < 50) {
			return "redirect:/member/login";
		}

		Study dto = service.readEvent(eventNum);
		
		if(dto == null) {
			return "redirect:/studyManage/lotto";
		}
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		
		return "admin.studyManage.lottowrite";
	}
	
	@RequestMapping(value = "event/update", method = RequestMethod.POST)
	public String updateSubmit(Study dto, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return "redirect:/member/login";
		}
		
		if(info.getMembership() < 50) {
			return "redirect:/member/login";
		}
		
		return "redirect:/studyManage/lotto";
	}
	
}
