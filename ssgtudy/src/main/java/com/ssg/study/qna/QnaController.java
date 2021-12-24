package com.ssg.study.qna;

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

@Controller("qna.qnaController")
@RequestMapping("/qna/*")
public class QnaController {
	@Autowired
	private QnaService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("list")
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
		
		List<Qna> list = service.listBoard(map);
		
		//리스트의 번호
		Date endDate = new Date();
		long gap;
		int listNum, n=0;
		for(Qna dto : list) {
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
		
		listUrl = cp + "/qna/list";
		articleUrl = cp + "/qna/article?page="+current_page;
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
		
		return ".qna.list";
	}
	
	@RequestMapping(value="write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception {
	
		model.addAttribute("mode", "write");
		return ".qna.write";
	}
	
	@RequestMapping(value="/qna/write", method=RequestMethod.POST)
	public String writeSubmit(Qna dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "qna";

		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/qna/list";
	}
	
	@RequestMapping(value="article")
	public String article (
			@RequestParam int qnaNum,
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
		
		service.updateHitCount(qnaNum);
		
		Qna dto = service.readBoard(qnaNum);
		if(dto == null) {
			return "redirect:/qna/list?" + query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qnaNum", qnaNum);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		Qna preReadDto = service.preReadBoard(map);
		Qna nextReadDto = service.nextReadBoard(map);
		
		List<Qna> listFile = service.listFile(qnaNum);
		
		// 게시글 좋아요 여부
		map.put("userId", info.getUserId());
		boolean userBoardLiked = service.userBoardLiked(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("userBoardLiked",userBoardLiked);
		model.addAttribute("listFile", listFile);
		model.addAttribute("query", query);
		
		return ".qna.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int qnaNum,
			@RequestParam String page,
			Model model,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Qna dto = service.readBoard(qnaNum);
		if(dto == null || ! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/qna/list?page="+page;
		}
		
		List<Qna> listFile = service.listFile(qnaNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("listFile", listFile);
		
		return ".qna.write";
	}
	
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Qna dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + File.separator + "uploads" + File.separator + "qna";		
		
			dto.setUserId(info.getUserId());
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/qna/list?page="+page;
	
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int qnaNum,
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
		String pathname = root + "uploads" + File.separator + "qna";
		
		service.deleteBoard(qnaNum, pathname, info.getUserId());
		
		return "redirect:/qna/list?"+query;
	}
	
	@RequestMapping(value="download")
	public void download(@RequestParam int qnafileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "bbs";
		
		boolean b = false;
		
		Qna dto = service.readFile(qnafileNum);
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
	
	@RequestMapping(value="zipdownload")
	public void zipdownload(@RequestParam int qnaNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "qna";
		
		boolean b = false;
		
		List<Qna> listFile = service.listFile(qnaNum);
		if(listFile.size() > 0) {
			String [] sources = new String[listFile.size()];
			String [] originals = new String[listFile.size()];
			String zipFilename = qnaNum + ".zip";
			
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
				out.println("<script>alert('파일 다운로드가 불가능합니다.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int qnafileNum, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "qna";
		
		Qna dto = service.readFile(qnafileNum);
		if(dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);	
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "qnafileNum");
		map.put("qnaNum", qnafileNum );
		service.deleteFile(map);
		
		//작업결과를 json으로 전송
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");

		return model;
	}
	
	// 게시글 좋아요 추가/삭제 : AJAX-JSON
	@RequestMapping(value="insertBoardLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(@RequestParam int qnaNum,
			@RequestParam boolean userLiked,
			HttpSession session){
		String state= "true";
		int boardLikeCount = 0;
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("qnaNum", qnaNum);
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
		boardLikeCount = service.boardLikeCount(qnaNum);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state );
		model.put("boardLikeCount", boardLikeCount );
	
		return model;
	}
	
	// 댓글 및 댓글의 답글 등록 : AJAX-JSON
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
	
	//댓글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(@RequestParam int qnaNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("qnaNum", qnaNum);
		
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
		
		// AJAX용 페이지
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
	
		//포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply );
		model.addAttribute("pageNo", current_page );
		model.addAttribute("replyCount", dataCount );
		model.addAttribute("total_page", total_page );
		model.addAttribute("paging", paging );

		return "/qna/listReply";
	}
		
	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
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
		
	// 댓글의 답글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReplyAnswer")
	public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception {
		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));	
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "/qna/listReplyAnswer";
	}
	
	// 댓글의 답글 개수 : AJAX-JSON
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
	
	@RequestMapping(value = "report")
	@ResponseBody
	public Map<String, Object> memberWithdraw(@RequestParam(value = "qnaNum") int qnaNum,
			@RequestParam String reason, 
			HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String status = "true";
		// 신고시에 필요한 유저 id
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		map.put("userId", userId);
		map.put("qnaNum", qnaNum);
		map.put("reason", reason);
		
		
		try {
			int result = service.insertQnaReport(map);
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

}
