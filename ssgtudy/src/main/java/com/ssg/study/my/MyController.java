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
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		int rows = 10;
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
		if (current_page > total_page) {
			current_page = total_page;
		}
		List<MyBoard> list = service.myList(map);

		int listNum, n = 0;
		for (MyBoard dto : list) {
			listNum = dataCount - (start + n - 1);
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
	
	@RequestMapping(value = "article")
	public String article(
			@RequestParam int num,
			@RequestParam String tbName,
			@RequestParam String page,
			Model model
			) throws Exception {
		
		String boardTitle = "";
		String field = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("tbName", tbName);
		
		if(tbName.equals("bbs")) {
			boardTitle = "자유게시판";
			field = "bbsNum";
		} else if(tbName.equals("study_Board")) {
			boardTitle = "스터디 게시판";
			field = "boardNum";
		} else if(tbName.equals("study_ad")) {
			boardTitle = "스터디 홍보 게시판";
			field = "boardNum";
		} else if(tbName.equals("community")) {
			boardTitle = "커뮤니티 게시판";
			field = "boardNum";
		} else if(tbName.equals("qna")) {
			boardTitle = "질문과 답변";
			field = "qnaNum";
		}
		map.put("field", field);
		map.put("num", num);
		
		MyBoard dto = service.myReadBoard(map);
		if(dto == null) {
			return "redirect:/my/list?page="+page;
		}
		
		dto.setBoardTitle(boardTitle);
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto", dto);
		model.addAttribute("field", field);
		model.addAttribute("tbName", tbName);
		model.addAttribute("page", page);
		
		return ".my.article";
	}

	
	// 추천글 리스트
	@RequestMapping(value = "recommend")
	public String recommend(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpServletRequest req, HttpSession session, Model model) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		int rows = 5;
		int recdataCount;
		int total_page;

		Map<String, Object> map = new HashMap<String, Object>();
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("userId", info.getUserId());
		map.put("start", start);
		map.put("end", end);

		recdataCount = service.recdataCount(map);
		total_page = myUtil.pageCount(rows, recdataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}
		List<MyBoard> list = service.recList(map);

		int listNum, n = 0;
		for (MyBoard dto : list) {
			listNum = recdataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}

		String listUrl = cp + "/my/recommend";

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("recdataCount", recdataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return ".my.recommend";
	}
}
