package com.ssg.study.study;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.MyUtil;
import com.ssg.study.member.SessionInfo;

@Controller("study.studyController")
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
	public String writeForm(Model model) throws Exception {
		
		model.addAttribute("mode", "enroll");
		
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
		dto.setRole(20); // ????????? - ???????????? ??????
		
		try {
			int seq = service.selectStudyNum(); // ??????????????? StudyNum ?????????
			dto.setStudyNum(seq);
			
			service.insertStudy(dto); // study ????????? ??????
			} catch (Exception e) {
		}
		
		return "redirect:/study/list";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(Model model,
			@RequestParam int studyNum,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		
		if( info == null) {
			return "redirect:/member/login";
		}
		String userId = info.getUserId();		
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		
		Study dto = null;
		try {
			dto = service.readStudy(map);
			if(dto == null) {
				return "redirect:/study/list";
			}
		} catch (Exception e) {
			return "redirect:/study/list";
		}
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".study.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Study dto,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if( info == null) {
			return "redirect:/member/login";
		}
		
		if( dto.getRole() != 20) {
			return "redirect:/study/list";
		} 
		
		service.updateStudy(dto);
		
		return "redirect:/study/list";
	}
	
	@RequestMapping(value = "inactive")
	public String inactiveStudy(Model model,
			@RequestParam int studyNum,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		
		if( info == null) {
			return "redirect:/member/login";
		}
		String userId = info.getUserId();		
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		
		Study dto = service.readStudy(map);
		if(dto == null) {
			return "redirect:/study/list";
		}
		
		if(dto.getRole() != 20 ) {
			return "redirect:/study/list";
		}
		
		service.inactiveStudy(studyNum);
		
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
		
		if( dto == null) {
			dto = service.visitStudy(studyNum); // ?????????
		}
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		
		listMap = service.readCategory(studyNum);
		
		model.addAttribute("listCategory", listMap);
		model.addAttribute("dto", dto);
		
		return ".study.home";
	}
	
	// ???????????????
	@RequestMapping(value = "memberList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> memberList(
			@RequestParam(value = "studyNum") int studyNum,
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page
			) throws Exception {
		String status = "true";
		List<Study> memberList = null;
		int rows = 10;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("studyNum", studyNum);
		
		int dataCount = service.memberDataCount(paramMap);
		int start = (current_page - 1) * rows + 1;
		int end = (current_page * rows);
		int total_page = myUtil.pageCount(rows, dataCount);
		
		if (current_page > total_page) {
			current_page = total_page;
		}
		
		paramMap.put("start", start);
		paramMap.put("end", end);

		try {
			memberList = service.memberList(paramMap);
		} catch (Exception e) {
			status = "false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("memberList", memberList);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("total_page", total_page);
		model.put("status", status);
		
		return model;
	}
	
	// AJAX-HTML
	@RequestMapping(value = "addCategory", method = RequestMethod.GET)
	public String formCategory(Model model,
			@RequestParam(value = "studyNum")int studyNum,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studyNum", studyNum);
		map.put("userId", userId);
		
		Study dto = service.readStudy(map);
		List<Map<String, Object>> categoryList = service.readCategory(studyNum);
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		listMap = service.readCategory(studyNum);
		
		model.addAttribute("listCategory", listMap);
		model.addAttribute("dto", dto);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("studyNum", studyNum);
		return "study/addCategory";
	}
	
	// AJAX-JSON
	@RequestMapping(value = "addCategory", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addCategory(
			@RequestParam(value = "studyNum")int studyNum,
			@RequestParam(value = "categoryName")String categoryName,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studyNum", studyNum);
		map.put("categoryName", categoryName);
		service.insertCategory(map);
		
		Map<String, Object> readMap = new HashMap<String, Object>();
		readMap.put("studyNum", studyNum);
		readMap.put("userId", userId);
		Study dto = service.readStudy(readMap);
		List<Map<String, Object>> categoryList = service.readCategory(studyNum);
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		listMap = service.readCategory(studyNum);
		
		model.put("listCategory", listMap);
		model.put("dto", dto);
		model.put("categoryList", categoryList);
		
		
		return model;
	}

	// AJAX-JSON
	@RequestMapping(value = "updateCategory", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> updateCategory(
			@RequestParam(value = "categoryNum") int categoryNum,
			@RequestParam(value = "categoryName") String categoryName,
			HttpServletRequest req) throws Exception {
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			categoryName = URLDecoder.decode(categoryName, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryNum", categoryNum);
		map.put("categoryName", categoryName);
		
		Map<String, Object> model = new HashMap<String, Object>();
		return model;
	}
	
	// AJAX-JSON
	@RequestMapping(value = "deleteCategory", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> deleteCategory(
			@RequestParam(value = "categoryNum") int categoryNum) throws Exception {
		
		service.deleteCategory(categoryNum);
		
		Map<String, Object> model = new HashMap<String, Object>();
		return model;
	}
	
	@RequestMapping(value = "ad") // ????????? ?????? ????????? 
	public String adList(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();

		int rows = 20; // ??? ????????? ???????????? ????????? ???
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET ????????? ??????
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		

		// ?????? ????????? ???
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.studyAdDataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		

		// ?????? ????????? ????????? ???????????? ?????? ??????????????? ?????? ??? ??????
		if (total_page < current_page) {
			current_page = total_page;
		}

		// ???????????? ????????? ???????????? ????????????
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Study> adList = service.studyAdList(map);
		
		// ???????????? ??????
		int listNum, n = 0;
		for (Study dto : adList) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "study/ad";
		String articleUrl = cp + "/study/ad/article?page=" + current_page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "&" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", adList);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".study.adlist";
	}
	
	@RequestMapping(value = "ad/write", method = RequestMethod.GET) // ????????? ?????? ????????? 
	public String adWriteForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		List<Study> myStudyList = service.studyHomeList(userId);
		
		model.addAttribute("mode", "write");
		model.addAttribute("myStudyList", myStudyList);

		return ".study.adwrite";
	}
	
	@RequestMapping(value = "ad/write", method = RequestMethod.POST) // ????????? ?????? ????????? 
	public String adWriteSubmit(Study dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		try {
			dto.setUserId(userId);
			service.insertStudyAd(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/study/ad";
	}
	
	// ????????? ?????? ???????????????
	@RequestMapping(value = "ad/article")
	public String studyAdArticle(@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model	) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.updateStudyAdHitCount(boardNum);
		Study dto = service.readStudyAd(boardNum);
		if (dto == null) {
			return "redirect:/study/ad?" + query;
		}
		
		// CKEditor ?????????????????? ?????? ???????????????.
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".study.article";
	}
	
	// ????????? ?????? ????????? ??????
	@RequestMapping(value = "ad/update", method = RequestMethod.GET)
	public String studyAdUpdate(@RequestParam int boardNum,
			@RequestParam String page,
			HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		List<Study> myStudyList = service.studyHomeList(userId);
		
		Study dto = service.readStudyAd(boardNum);
		
		if (dto == null) {
			return "redirect:/study/ad?page=" + page;
		}
		
		if (!info.getUserId().equals(dto.getUserId())) {
			return "redirect:/study/ad?page=" + page;
		}

		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("myStudyList", myStudyList);
		
		return ".study.adwrite";
	}
	// ????????? ?????? ????????? ?????? ??????
	@RequestMapping(value = "ad/update", method = RequestMethod.POST)
	public String studyAdUpdateSubmit(Study dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			dto.setUserId(info.getUserId());
			service.updateStudyAd(dto);
		} catch (Exception e) {
		}

		return "redirect:/study/ad?page=" + page;
	}
	
	@RequestMapping(value = "ad/delete")
	public String studyAdDelete(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", boardNum);
		map.put("userId", info.getUserId());
		map.put("membership", info.getMembership());

		service.deleteStudyAd(map);
		
		return "redirect:/study/ad?" + query;
	}
	@RequestMapping(value = "member")
	@ResponseBody
	public Map<String, Object> studyMemberAdd(@RequestParam int studyNum,
			@RequestParam String userId,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		String status = "false";
		
		if(info == null) {
			status = "403"; // ????????? ?????????????????? ??????????????? ?????????
			map.put("status", status);
			return map;
		}
		
		Study dto = new Study();
		dto.setUserId(userId);
		dto.setStudyNum(studyNum);
		dto.setRole(0); // 0??? ???????????? ??????
		
		try {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("userId", userId);
			paramMap.put("studyNum", studyNum);
			int applyCount = service.memberCount(paramMap); // ????????? ????????????
			if( applyCount < 1) { // 0???????????? ??????????????????
				service.insertStudyMember(dto);				
			} else {
				status = "400"; // ????????? ???????????? ??????
			}
			
		} catch (Exception e) {
			status = "400";
		}
		map.put("status", status);
		return map;
	}
	
	// ?????? ?????????(jsp ??????)
	@RequestMapping(value = "rank")
	public String studyRankGet() throws Exception {

		return ".study.rank";
	}
	
	@RequestMapping(value = "rank/list2")
	public String studyRankSearch(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "studyName") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();

		int rows = 10; // ??? ????????? ???????????? ????????? ???
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET ????????? ??????
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		

		// ?????? ????????? ???
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		dataCount = service.rankDataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		

		// ?????????????????? ?????? ??????????????? ?????? ??? ??????
		if (total_page < current_page) {
			current_page = total_page;
		}

		// ???????????? ????????? ???????????? ????????????
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Study> rankList = service.rankList(map);
		
		/*
		int listNum, n = 0;
		for (Study dto : rankList) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		*/
		
		String query = "";
		String listUrl = cp + "/study/rank/list2?";
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("postRankList", rankList);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".study.rank2";
	}
	
	// AJAX - MAP???  JSON?????? ???????????? ??????
	@RequestMapping(value = "rank/list", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> studyRankList(@RequestParam(value = "pageNo", defaultValue = "1") 
		int current_page) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String status = "true";
		List<Study> rankList = null;
		int rows = 5;
		int dataCount = service.rankDataCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		try {
			rankList = service.rankList(map);
		} catch (Exception e) {
			status = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("pageNo", current_page);
		model.put("status", status);
		model.put("rankList", rankList);
		return model;
	}
	
	// ????????? ???????????? ??? ?????????
	// AJAX - HTML
	@RequestMapping(value = "home/{studyNum}/list")
	public String studyListByCategory(
			@RequestParam(value = "page", defaultValue = "1")int current_page,
			@RequestParam(value = "categoryNum") int categoryNum,
			Model model,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@PathVariable int studyNum,
			HttpSession session,
			HttpServletRequest req) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>(); // ??????????????? ????????? ????????????
		SessionInfo info = (SessionInfo)session.getAttribute("member");	
		String status = "true";
		
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) { // GET ????????? ??????
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("categoryNum", categoryNum);
				
		dataCount = service.studyListByCategoryDataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		// ?????? ????????? ????????? ???????????? ?????? ??????????????? ?????? ??? ??????
		if (total_page < current_page) {
			current_page = total_page;
		}

		// ???????????? ????????? ???????????? ????????????
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Study> listByCategory = null;
		listByCategory = service.studyListByCategory(map);
		
		// ???????????? ??????
		int listNum, n = 0;
		for (Study dto : listByCategory) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "study/home/"+studyNum+"/list?categoryNum="+categoryNum;
		String articleUrl = cp + "/study/home/"+studyNum+"/article?page=" + current_page+"&categoryNum="+categoryNum;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "&" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		Study dto = null;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", info.getUserId());
		paramMap.put("studyNum", studyNum);
		dto = service.readStudy(paramMap);
		
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("listUrl", listUrl);
		model.addAttribute("studyNum", studyNum);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("status", status);
		model.addAttribute("listByCategory", listByCategory);
		
		model.addAttribute("studyDto", dto);
		
		model.addAttribute("categoryNum", categoryNum);
		return "study/homelist";
	}
	
	// ????????? ???????????? ??? ?????????
	// AJAX - HTML
	@RequestMapping(value = "home/{studyNum}/list/write", method = RequestMethod.GET)
	public String studyWrite(Model model,
			@PathVariable int studyNum,
			HttpSession session) throws Exception {
		String status = "true";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");	
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Map<String, Object>> categoryList = service.readCategory(studyNum);
		
		String userId = info.getUserId();		
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		
		Study dto = null;
		try {
			dto = service.readStudy(map);
		} catch (Exception e) {
			status = "false";
			e.printStackTrace();
		}
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("mode", "write");
		model.addAttribute("studyNum", studyNum);
		model.addAttribute("studyDto", dto);
		model.addAttribute("status", status);
		
		return "study/homewrite";
	}
	
	// AJAX / HTML
	// ?????????????????? ???????????????????????? ????????? ??? ???
		@RequestMapping(value = "home/{studyNum}/list/write", method = RequestMethod.POST)
		public String studyWriteSubmit(@PathVariable int studyNum,
				HttpSession session, Study dto, 
				Model model) throws Exception {
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");	
			Map<String, Object> map = new HashMap<String, Object>();
			
			List<Map<String, Object>> categoryList = service.readCategory(studyNum);
			
			String userId = info.getUserId();		
			map.put("userId", userId);
			map.put("studyNum", studyNum);
			// ????????? ???????????????
			Study vo = service.readStudy(map);
			
			Map<String, Object> message = new HashMap<String, Object>();
			if(vo == null) {
				message.put("msg", "????????? ????????????.");
				return "study/homelist";
				
			} else if (vo.getRole() < 1) {
				message.put("msg", "?????? ????????? ????????? ???????????????.");
				return "study/homelist";
			}

			dto.setUserId(userId);
			service.insertEachStudyBoard(dto);				
			
			model.addAttribute("studyNum", studyNum);
			model.addAttribute("categoryList", categoryList);
			return "study/homelist";
		}
	
		// AJAX - HTML
	@RequestMapping(value = "home/{studyNum}/article")
	public String articleByCategory(
			@RequestParam(value = "page")String page,
			@RequestParam(value = "categoryNum") int categoryNum,
			Model model,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@PathVariable int studyNum,
			@RequestParam int boardNum,
			HttpSession session,
			HttpServletRequest req) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");
		Map<String, Object> map = new HashMap<String, Object>();
		SessionInfo info = (SessionInfo)session.getAttribute("member");	
		
		String userId = info.getUserId();		
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		
		String query = "page="+ page +"&categoryNum="+categoryNum;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.updateHitCountByCategory(boardNum); // ???????????????
		
		Map<String, Object> message = new HashMap<String, Object>();
		Study vo = service.readStudy(map); // ??? ????????? ????????? ????????? ????????????
		Study dto = null;
		if (vo == null || vo.getRole() == 0) {
			message.put("msg", "??????????????? ???????????? ?????? ??? ????????????.");
		} else if(vo.getRole() >= 1) { // ?????????????????? ?????? ??? ????????????.
			dto = service.readArticleByCategory(boardNum);
		}
		
		// CKEditor ?????????????????? ?????? ???????????????.
		
		model.addAttribute("studyNum", studyNum);
		model.addAttribute("studyDto", vo); // ????????? ?????? ????????????????????? ?????????????????????????????? ??????
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("message", message);
		model.addAttribute("categoryNum", categoryNum);
		return "/study/homearticle";
	}
		
	// ????????? ????????? ????????? ?????? ????????? ???
	@RequestMapping(value = "manageMember")
	public String manageMember(@RequestParam(value="studyNum") int studyNum,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "nickName", defaultValue = "") String condition,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String cp = req.getContextPath();
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study dto = service.readStudy(map);
		// ????????? ????????? ???????????? ????????? ????????? ?????????
		if(dto.getRole() == 1 || dto.getRole() == 0) {
			return "redirect:home/"+studyNum;
		}

		int rows = 10; // ??? ????????? ???????????? ?????? ???
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET ????????? ??????
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		

		// ?????? ????????? ???
		Map<String, Object> paramMap = new HashMap<String, Object>();
		// paramMap.put("condition", condition);
		paramMap.put("keyword", keyword);
		paramMap.put("studyNum", studyNum);
		
		if(dto.getRole() == 10) {
			paramMap.put("role", "10");
			dataCount = service.memberDataCount(paramMap);
		} else {
			dataCount = service.memberDataCount(paramMap);
		}

		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		

		// ?????? ????????? ????????? ???????????? ?????? ??????????????? ?????? ??? ??????
		if (total_page < current_page) {
			current_page = total_page;
		}

		// ???????????? ????????? ???????????? ????????????
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		List<Study> memberList = null;
		
		if(dto.getRole() == 10) {
			paramMap.put("role", "10");
			memberList = service.memberList(paramMap);
		} else {
			memberList = service.memberList(paramMap);			
		}
		
		
		// ???????????? ??????
		int listNum = 0;
		int n = 1;
		for (Study s : memberList) {
			listNum = n++;
			s.setListNum(listNum);
		}
		
		String query = "";
		String listUrl = cp + "/study/manageMember?studyNum="+studyNum;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("vo", dto);
		
		model.addAttribute("list", memberList);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		
		model.addAttribute("studyNum", studyNum);
		
		return ".study.memberlist";
		
	}
	
	// ??????????????? ?????? ??????
	@RequestMapping(value = "memberstatus")
	public String updateMember(@RequestParam(value = "studyNum") int studyNum,
			@RequestParam(value = "memberNum") int memberNum,
			@RequestParam(value = "roleValue") int role,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study dto = service.readStudy(map);
		// ????????? ??? ?????? ???????????? ????????? ????????? ?????????
		if(dto.getRole() == 1 || dto.getRole() == 0) {
			return "redirect:study/home/"+studyNum;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("memberNum", memberNum);
		paramMap.put("role", role);
		
		try {
			service.updateMember(paramMap);
		} catch (Exception e) {
			return "redirect:home/"+studyNum;
		}
		
		return "redirect:/study/manageMember?studyNum="+studyNum;
	}
	@RequestMapping(value = "memberRemove")
	public String deleteMember(@RequestParam(value = "studyNum")int studyNum, 
			@RequestParam(value = "memberNum") int memberNum ) throws Exception {
		try {
			service.deleteMember(memberNum);
		} catch (Exception e) {
		}
		return "redirect:/study/manageMember?studyNum="+studyNum;
	}
	
	@RequestMapping( value = "questCount")
	@ResponseBody
	public Map<String, Object> updateQuestCount(@RequestParam int studyNum, HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		String status = "true";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study dto = service.readStudy(map);
		
		if(dto == null) { // ????????? ?????????????????? ??????????????????
			status = "403";
			model.put("status", status);
			return model;
		} else if(dto.getRole() == 1 || dto.getRole() == 0) {
			status = "400";
			model.put("status", status);
			return model;
		} 
		
		Study vo = null;
		vo = service.questCountCheck(studyNum);
		
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DATE);
		String smonth = "";
		String sdate = "";
		String SYSDATE = "";
		if(Integer.toString(month).length() < 2 && Integer.toString(date).length() < 2) {
			smonth = "0"+ Integer.toString(month);
			sdate = "0" + Integer.toString(date);
			SYSDATE = Integer.toString(year)+"-"+smonth+"-"+sdate;
		} else if(Integer.toString(date).length() < 2) {
			sdate = "0"+ Integer.toString(date);
			SYSDATE = Integer.toString(year)+"-"+Integer.toString(month)+"-"+sdate;
		} else if(Integer.toString(month).length() < 2 ) {
			smonth = "0"+ Integer.toString(month);
			SYSDATE = Integer.toString(year)+"-"+smonth+"-"+Integer.toString(date);
		} else {
			SYSDATE = Integer.toString(year)+"-"+Integer.toString(month)+"-"+Integer.toString(date);
		}
		
		// ?????? ????????? ????????????????????? ???????????? null ????????????????????? ??? ????????? ???????????????.
		if(vo.getUpdateDate() == null) {
			String updateDate = Integer.toString(year)+"-"+Integer.toString(month)+"-"+Integer.toString(date-1);
			vo.setUpdateDate(updateDate);
		}
		
		if(vo.getUpdateDate().equals(SYSDATE) ) {
			status = "false";
			model.put("status", status);
			return model;
		}
		int questCount = 0;
		
		try {
			service.updateQuestCount(studyNum);
			questCount = vo.getQuestCount() + 1;
		} catch (Exception e) {
			status = "400";
		}
		
		model.put("status", status);
		model.put("questCount", questCount);
		return model;
	}
	
	@RequestMapping(value = "report")
	@ResponseBody
	public Map<String, Object> memberWithdraw(@RequestParam(value = "studyNum") int studyNum,
			@RequestParam String reason, 
			HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String status = "true";
		// ???????????? ????????? ?????? id
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		map.put("reason", reason);
		
		
		try {
			int result = service.insertStudyReport(map);
			if( result < 1) {
				status = "1"; 
			}
		} catch (Exception e) {
			status = "400";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("status", status);
		
		return model;
	}
	
	// ??????????????? ?????? ????????? ????????? ???
	@RequestMapping(value = "withdraw")
	@ResponseBody
	public Map<String, Object> withdraw(@RequestParam(value = "studyNum")int studyNum, 
			@RequestParam(value = "memberNum") int memberNum ) throws Exception {
		String status = "true";
		try {
			service.deleteMember(memberNum);
		} catch (Exception e) {
			status = "1"; // ????????? ????????????
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("status", status);
		model.put("studyNum", studyNum);
		return model;
	}
	
	@RequestMapping(value = "home/remove")
	public String studyArticleRemove(@RequestParam int boardNum,
			@RequestParam int categoryNum,
			@RequestParam int studyNum,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		// ????????????????????????
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study vo = service.readStudy(map);
		
		Study dto = new Study();
		dto = service.readArticleByCategory(boardNum);
		
		if(dto.getUserId().equals(userId)) { 
			service.deleteEachStudyBoard(boardNum);	
		} else if( vo.getRole() > 10 || info.getMembership() > 50) {
			service.deleteEachStudyBoard(boardNum);
		}
		
		return "study/homelist";
	}
	
	@RequestMapping(value = "home/{studyNum}/list/update", method = RequestMethod.GET)
	public String studyArticleUpdateForm(
			@RequestParam String page,
			@RequestParam int boardNum,
			@RequestParam int categoryNum,
			@PathVariable int studyNum,
			Model model,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Study dto = service.readArticleByCategory(boardNum);
		if(! dto.getUserId().equals(userId) ) { 
			return "study/home/"+studyNum;
		}
		
		List<Map<String, Object>> categoryList = service.readCategory(studyNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study studyDto = service.readStudy(map);
		
		model.addAttribute("studyDto", studyDto);
		model.addAttribute("studyNum", studyNum);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return "study/homewrite";
	}
	
	@RequestMapping(value = "home/{studyNum}/list/update", method = RequestMethod.POST)
	public String studyArticleUpdateSubmit(@RequestParam int boardNum,
			@RequestParam int categoryNum,
			@PathVariable int studyNum,
			@RequestParam String subject,
			@RequestParam String content,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Study dto = service.readArticleByCategory(boardNum);
		
		// ???????????? ?????????
		if(! dto.getUserId().equals(userId) ) { 
			return "study/homelist";
		}
		
		// ??????????????? ??? ??????
		Study vo = new Study();
		vo.setBoardNum(boardNum);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setCategoryNum(categoryNum);
		service.updateArticleByCategory(vo);
		
		return "study/homelist";
	}
	
	@RequestMapping(value = "study/purge")
	public String purgeStudy(@RequestParam int studyNum,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study dto = service.readStudy(map);
		
		// ????????? ?????? ????????? ?????? ??????
		if( dto.getRole() != 20) {
			return "redirect:/study/home/"+studyNum;
		}
		
		service.deleteStudy(studyNum);
		
		return "redirect:/study/list";
	}
	
	// AJAX - JSON ?????????????????? ??????
	@RequestMapping(value = "study/changeCategory")
	@ResponseBody
	public Map<String, Object> changeCategoryName(
			@RequestParam String categoryName,
			@RequestParam int categoryNum,
			@RequestParam int studyNum,
			HttpSession session
			) throws Exception {
		String status = "true";
		Map<String, Object> map = new HashMap<String, Object>();
		
		// ???????????? ????????? ??????????????????
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		// ???????????? ?????????????????? ??????
		map.put("userId", userId);
		map.put("studyNum", studyNum);
		Study dto = service.readStudy(map);
		// ????????? ?????? ????????? ???????????? ???????????? ??????
		if( dto.getRole() < 20) { 
			status = "400";
		}
		
		// ??????????????? ??????????????? map ???????????????
		map.clear(); 
		
		// ????????????????????? ??????
		map.put("categoryName", categoryName);
		map.put("categoryNum", categoryNum);
		
		service.updateCategory(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("status", status);
		return model;
	}
	
	@RequestMapping(value = "times")
	@ResponseBody
	public Map<String, Object> checkTimes(
			@RequestParam int studyNum
			) throws Exception {
		String status = "true";
		
		Study dto = service.readTimes(studyNum);

		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("dto", dto);
		model.put("status", status);
		return model;
	}
	
}
