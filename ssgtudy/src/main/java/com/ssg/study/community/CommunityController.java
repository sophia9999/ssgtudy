package com.ssg.study.community;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MidiDevice.Info;

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

@Controller("community.communityController")
@RequestMapping("/community/*")
public class CommunityController {
	@Autowired
	private CommunityService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "main")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Integer schoolCode = info.getSchoolCode();
		
		String cp = req.getContextPath();
	
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("schoolCode", schoolCode);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지 수가 변화된 경우
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		
		// 글 리스트
		List<Community> list = service.listBoard(map);
		
		// 리스트의 번호
		int listNum, n = 0;
		for(Community dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/community/main";
		String articleUrl = cp + "/community/article?page=" + current_page;
		if(keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length() != 0) {
			listUrl = cp + "/community/main?" + query;
			articleUrl = cp + "/community/article?page=" + current_page + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".community.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception {
		
		model.addAttribute("mode", "write");
		
		return ".community.write";
	}
	
	@RequestMapping(value = "/community/write", method = RequestMethod.POST)
	public String writeSubmit(Community dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "community";
			
			dto.setUserId(info.getUserId());
			dto.setSchoolCode(info.getSchoolCode());
			
			service.insertBoard(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/community/main";
	}
	
	@RequestMapping(value = "article")
	public String article(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page=" + page;
		if(keyword.length() != 0) {
			query += "&condition=" + condition +
					"&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		service.updateHitCount(boardNum);
		
		Community dto = service.readBoard(boardNum);
		if(dto == null) {
			return "redirect:/community/main?" + query;
		}
		
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("boardNum", boardNum);
		
		Community preReadDto = service.preReadBoard(map);
		Community nextReadDto = service.nextReadBoard(map);
		
		List<Community> listFile = service.listFile(boardNum);
		
		map.put("userId", info.getUserId());
		boolean userBoardLiked = service.userBoardLiked(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("userBoardLiked", userBoardLiked);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("listFile", listFile);
		
		return ".community.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int boardNum,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Community dto = service.readBoard(boardNum);
		if(dto == null || ! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/community/main";
		}
		
		List<Community> listFile = service.listFile(boardNum);
		
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return ".community.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Community dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "community";
		
		try {
			
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
		}
	
		return "redirect:/community/main?page=" + page;
	}
	
	@RequestMapping(value = "delete")
	public String delete(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page=" + page;
		if(keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + keyword;
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "community";
		
		service.deleteBoard(boardNum, pathname, info.getUserId(), info.getMembership());
		
		return "redirect:/community/main?" + query;
	}
	
	
	@RequestMapping(value = "download")
	public void download(@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "community";
		
		boolean b = false;
		
		Community dto = service.readFile(fileNum);
		if(dto != null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		
		if(! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능합니다.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value = "zipdownload")
	public void zipdownload(@RequestParam int boardNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "community";
		
		boolean b = false;
		
		List<Community> listFile = service.listFile(boardNum);
		if(listFile.size() > 0) {
			String[] sources = new String[listFile.size()];
			String[] originals = new String[listFile.size()];
			String zipFilename = boardNum + ".zip";
			
			for(int idx = 0; idx < listFile.size(); idx++) {
				sources[idx] = pathname + File.separator + listFile.get(idx).getSaveFilename();
				originals[idx] = File.separator + listFile.get(idx).getOriginalFilename();
			}
			
			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}
		
		if(! b) {
			try {
				resp.setContentType("text/html; charset=utf-8"); 
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능합니다.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int fileNum, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "community";
		
		Community dto = service.readFile(fileNum);
		if(dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("boardNum", fileNum);
		service.deleteFile(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		
		return model;
	}
	
	@RequestMapping(value = "insertBoardLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@RequestParam int boardNum,
			@RequestParam boolean userLiked,
			HttpSession session) throws Exception {
		String state = "true";
		int boardLikeCount = 0;
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("boardNum", boardNum);
		paramMap.put("userId", info.getUserId());
		
		try {
			if(userLiked) {
				service.deleteBoardLike(paramMap);
			} else {
				service.insertBoardLike(paramMap);
			}
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";	
		}
		
		boardLikeCount = service.boardLikeCount(boardNum);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("boardLikeCount", boardLikeCount);
		
		return model;
	}
	
	@RequestMapping(value = "listReply")
	public String listReply(@RequestParam int boardNum,
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			Model model) throws Exception {
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", boardNum);
		
		dataCount = service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Reply> listReply = service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "community/listReply";	
	}
	
	@RequestMapping(value = "insertReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(Reply dto, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam Map<String, Object> paramMap) {
		String state = "true";
		
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	@RequestMapping(value = "listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception {
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "community/listReplyAnswer";
	}
	
	@RequestMapping(value = "countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(@RequestParam(value = "answer") int answer) {
		int count = service.replyAnswerCount(answer);
		
		Map<String, Object> model = new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	@RequestMapping(value = "insertReplyLike", method = RequestMethod.POST)
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
			state = "liked";
		} catch(Exception e) {
			state = "false";
		}
		
		replyLikeCount = service.replyLikeCount(replyNum);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("replyLikeCount", replyLikeCount);
		
		return model;
	}
	
	@RequestMapping(value = "boardReport", method = RequestMethod.GET)
	public String reportForm(@RequestParam int boardNum,
			@RequestParam String page,
			Model model) throws Exception {
		
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("page", page);
		
		return ".community.boardReport";
	}
	
	@RequestMapping(value = "/community/boardReport", method = RequestMethod.POST)
	public String reportSubmit(Community dto, 
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			if(dto.getReason().equals("기타")) {
				dto.setReason(dto.getReason_etc());
			}
			service.insertBoardReport(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "redirect:/community/main";
	}
	
	@RequestMapping(value = "replyReport", method = RequestMethod.GET)
	public String replyReportForm(@RequestParam int boardNum,
			@RequestParam int replyNum,
			@RequestParam String page,
			Model model) throws Exception {
		
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("replyNum", replyNum);
		model.addAttribute("page", page);
		
		return ".community.replyReport";
	}
	
	@RequestMapping(value = "/community/replyReport", method = RequestMethod.POST)
	public String replyReportSubmit(Reply dto, 
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			if(dto.getReason().equals("기타")) {
				dto.setReason(dto.getReason_etc());
			}
			service.insertReplyReport(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "redirect:/community/main";
	}
}
