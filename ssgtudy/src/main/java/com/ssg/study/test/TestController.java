package com.ssg.study.test;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.MyUtil;
import com.ssg.study.member.SessionInfo;



@Controller("test.testController")
@RequestMapping("/test/*")
public class TestController {
	@Autowired
	private TestService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;

	@RequestMapping("mock")
	public String list(
			@RequestParam(value = "page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows = 5;
		int dataCount;
		int total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Mock> list = service.listBoard(map);
		
		//???????????? ??????
		Date endDate = new Date();
		long gap;
		int listNum, n=0;
		for(Mock dto : list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyy-MM-dd");
			Date beginDate = formatter.parse(dto.getReg_date());
			
			gap = (endDate.getTime() - beginDate.getTime()) / (60*60*1000);
			dto.setGap(gap);
			
			dto.setReg_date(dto.getReg_date().substring(0,10));
			n++;
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl;
		String articleUrl;
		if(keyword.length() != 0) {
			query = "condition="+condition+"&keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		listUrl = cp + "/test/mock";
		articleUrl = cp + "/test/article?page="+current_page;
		if(query.length()!= 0) {
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".test.mock";
	}


	@RequestMapping(value="write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception {
	
		model.addAttribute("mode", "write");
		return ".test.write";
	}
	
	@RequestMapping(value="/test/write", method=RequestMethod.POST)
	public String writeSubmit(Mock dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mock";

		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/test/mock";
	}
		
	@RequestMapping(value="article")
	public String article (
			@RequestParam int testNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		keyword= URLDecoder.decode(keyword, "utf-8");
		
		String query = "page=" + page;
		if(keyword.length() != 0 ) {
			query += "condition="+condition+"&keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		service.updateHitCount(testNum);
		
		Mock dto = service.readBoard(testNum);
		if(dto == null) {
			return "redirect:/test/mock?" + query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("testNum", testNum);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		Mock preReadDto = service.preReadBoard(map);
		Mock nextReadDto = service.nextReadBoard(map);
		
		List<Mock> listFile = service.listFile(testNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("query", query);
		
		return ".test.article";
	}
		
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int testNum,
			@RequestParam String page,
			Model model,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Mock dto = service.readBoard(testNum);
		if(dto == null || ! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/test/mock?page="+page;
		}
		
		List<Mock> listFile = service.listFile(testNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("listFile", listFile);
		
		return ".test.write";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Mock dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		 
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + File.separator + "uploads" + File.separator + "mock";		
		
			dto.setUserId(info.getUserId());
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/test/mock?page="+page;
	
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int testNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="")String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "condition="+condition+"&keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mock";
		
		service.deleteBoard(testNum, pathname, info.getUserId());
		
		return "redirect:/test/mock?"+query;
	}
	
	@RequestMapping(value="download")
	public void download(@RequestParam int test_fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mock";
		
		boolean b = false;
		
		Mock dto = service.readFile(test_fileNum);
		if(dto != null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);	
		}
		if(! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('?????? ??????????????? ??????????????????.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value="zipdownload")
	public void zipdownload(@RequestParam int testNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mock";
		
		boolean b = false;
		
		List<Mock> listFile = service.listFile(testNum);
		if(listFile.size() > 0) {
			String [] sources = new String[listFile.size()];
			String [] originals = new String[listFile.size()];
			String zipFilename = testNum + ".zip";
			
			for( int idx = 0; idx < listFile.size(); idx++) {
				sources[idx] = pathname + File.separator + listFile.get(idx).getSaveFilename();
				originals[idx] = File.separator + listFile.get(idx).getOriginalFilename();
			}
			
			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}
		if(! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('?????? ??????????????? ??????????????????.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int test_fileNum, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mock";
		
		Mock dto = service.readFile(test_fileNum);
		if(dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);	
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "test_fileNum");
		map.put("testNum", test_fileNum );
		service.deleteFile(map);
		
		//??????????????? json?????? ??????
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");

		return model;
	}	

	// ?????? ??? ????????? ?????? ?????? : AJAX-JSON
	@RequestMapping(value="insertReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(Reply dto, HttpSession session){
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	//?????? ????????? : AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(@RequestParam int testNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("testNum", testNum);
		
		dataCount = service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page -1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Reply> listReply = service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// AJAX??? ?????????
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
	
		//???????????? jsp??? ?????? ?????????
		model.addAttribute("listReply", listReply );
		model.addAttribute("pageNo", current_page );
		model.addAttribute("replyCount", dataCount );
		model.addAttribute("total_page", total_page );
		model.addAttribute("paging", paging );

		return "/test/listReply";
	}
		
	// ?????? ??? ????????? ?????? ?????? : AJAX-JSON
	@RequestMapping(value="deleteReply", method= RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam Map<String, Object> paramMap){
		String state="true";
		
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
		
	// ????????? ?????? ????????? : AJAX-TEXT
	@RequestMapping(value="listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception {
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));	
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "/test/listReplyAnswer";
	}
	
	// ????????? ?????? ?????? : AJAX-JSON
	@RequestMapping(value="countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(@RequestParam(value="answer") int answer) {
		int count = service.replyAnswerCount(answer);
		
		Map<String, Object> model = new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	@RequestMapping(value="insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam int replyNum,
			@RequestParam boolean userReplyLiked,
			HttpSession session) {
		String state = "true";
		int replyLikeCount = 0;
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("replyNum", replyNum);
		paramMap.put("userId", info.getUserId());
		
		try {
			if(userReplyLiked) {
				service.deleteReplyLike(paramMap);
			} else {
				service.insertReplyLike(paramMap);			
			}
		} catch (DuplicateKeyException e) {
			state= "liked";
		} catch (Exception e) {
			state= "false";
		}
		
		replyLikeCount = service.replyLikeCount(replyNum);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("replyLikeCount", replyLikeCount);
		
		return model;
	}

}
