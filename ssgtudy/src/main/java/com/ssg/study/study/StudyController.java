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
		dto.setRole(20); // 생성자 - 스터디장 설정
		
		try {
			int seq = service.selectStudyNum(); // 시퀀스에서 StudyNum 가져옴
			dto.setStudyNum(seq);
			
			service.insertStudy(dto); // study 테이블 삽입
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
			dto = service.visitStudy(studyNum); // 방문시
		}
		
		List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
		
		listMap = service.readCategory(studyNum);
		
		model.addAttribute("listCategory", listMap);
		model.addAttribute("dto", dto);
		
		return ".study.home";
	}
	
	// 멤버리스트
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
	
	@RequestMapping(value = "ad") // 스터디 홍보 게시판 
	public String adList(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();

		int rows = 20; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.studyAdDataCount(map);
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
		
		List<Study> adList = service.studyAdList(map);
		
		// 리스트의 번호
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
	
	@RequestMapping(value = "ad/write", method = RequestMethod.GET) // 스터디 홍보 게시글 
	public String adWriteForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		List<Study> myStudyList = service.studyHomeList(userId);
		
		model.addAttribute("mode", "write");
		model.addAttribute("myStudyList", myStudyList);

		return ".study.adwrite";
	}
	
	@RequestMapping(value = "ad/write", method = RequestMethod.POST) // 스터디 홍보 게시글 
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
	
	// 스터디 홍보 게시글보기
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
		
		// CKEditor 사용했으므로 심볼 안바꿔도됨.
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".study.article";
	}
	
	// 스터디 홍보 게시판 수정
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
	// 스터디 홍보 게시판 수정 완료
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
			status = "403"; // 로그인 안되어있으면 로그인하러 가도록
			map.put("status", status);
			return map;
		}
		
		Study dto = new Study();
		dto.setUserId(userId);
		dto.setStudyNum(studyNum);
		dto.setRole(0); // 0이 대기중인 멤버
		
		try {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("userId", userId);
			paramMap.put("studyNum", studyNum);
			int applyCount = service.memberCount(paramMap); // 한번만 신청하게
			if( applyCount < 1) { // 0번일때만 신청가능하게
				service.insertStudyMember(dto);				
			} else {
				status = "400"; // 스터디 참여신청 실패
			}
			
		} catch (Exception e) {
			status = "400";
		}
		map.put("status", status);
		return map;
	}
	
	// 일반 포워딩(jsp 반환)
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

		int rows = 20; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		dataCount = service.rankDataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		

		// 비활성화되어 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}

		// 리스트에 출력할 데이터를 가져오기
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
	
	// AJAX - MAP을  JSON으로 변환해서 반환
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
	
	// 홈에서 카테고리 별 리스트
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
		Map<String, Object> map = new HashMap<String, Object>(); // 카테고리별 리스트 나오게끔
		SessionInfo info = (SessionInfo)session.getAttribute("member");	
		String status = "true";
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("categoryNum", categoryNum);
				
		dataCount = service.studyListByCategoryDataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows+ 1;
		map.put("start", start);
		map.put("end", end);
		
		List<Study> listByCategory = null;
		listByCategory = service.studyListByCategory(map);
		
		// 리스트의 번호
		int listNum, n = 0;
		for (Study dto : listByCategory) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/home/"+studyNum+"/list?categoryNum="+categoryNum;
		String articleUrl = cp + "/home/"+studyNum+"/article?page=" + current_page+"&categoryNum="+categoryNum;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "&" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
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
	
	// 홈에서 카테고리 별 리스트
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
		}
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("mode", "write");
		model.addAttribute("studyNum", studyNum);
		model.addAttribute("studyDto", dto);
		model.addAttribute("status", status);
		
		return "study/homewrite";
	}
	
	// 스터디홈에서 카테고리탭누르고 글작성 할 때
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
			// 스터디 회원아니면
			Study vo = service.readStudy(map);
			if(vo == null) {
				return "redirect:/study/home/"+studyNum;
			} else if (vo.getRole() <= 1) {
				// 스터디 일반멤버 or 관리자가 아니면
				return "redirect:/study/home/"+studyNum;
			}

			dto.setUserId(userId);
			service.insertEachStudyBoard(dto);				

			
			model.addAttribute("studyNum", studyNum);
			model.addAttribute("categoryList", categoryList);
			return "redirect:/study/home/"+studyNum;
		}
	
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
		
		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.updateArticleByCategory(boardNum);
		
		Study dto = service.readStudy(map);
		if (dto == null) {
			return "redirect:/study/home/"+studyNum;
		}
		
		// CKEditor 사용했으므로 심볼 안바꿔도됨.
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".study.homearticle";
	}
		
	// 스터디 홈에서 구성원 관리 눌렀을 때
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
		// 스터디 장혹은 관리자가 아니면 홈으로 가세요
		if(dto.getRole() == 1 || dto.getRole() == 0) {
			return "redirect:home/"+studyNum;
		}

		int rows = 10; // 한 화면에 보여주는 멤버 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		

		// 전체 페이지 수
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
		

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}

		// 리스트에 출력할 데이터를 가져오기
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
		
		
		// 리스트의 번호
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
	
	// 스터디멤버 역할 변경
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
		// 스터디 장 혹은 관리자가 아니면 홈으로 가세요
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
		
		if(dto == null) { // 로그인 안되어있으면 로그인창가기
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
		
		String SYSDATE = Integer.toString(year)+"-"+Integer.toString(month)+"-"+Integer.toString(date);
		// System.out.println(SYSDATE);
		// 아직 한번도 목표달성한적이 없을경우 null 로되어있으므로 그 전날을 설정해준다.
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
		// 신고시에 필요한 유저 id
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
	
	// 일반회원이 직접 스터디 탈퇴할 때
	@RequestMapping(value = "withdraw")
	@ResponseBody
	public Map<String, Object> withdraw(@RequestParam(value = "studyNum")int studyNum, 
			@RequestParam(value = "memberNum") int memberNum ) throws Exception {
		String status = "true";
		try {
			service.deleteMember(memberNum);
		} catch (Exception e) {
			status = "1"; // 멤버만 탈퇴가능
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("status", status);
		model.put("studyNum", studyNum);
		return model;
	}
}
