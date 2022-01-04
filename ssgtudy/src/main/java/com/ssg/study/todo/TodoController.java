package com.ssg.study.todo;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.MyUtil;
import com.ssg.study.member.SessionInfo;

@Controller("todo.TodoController")
@RequestMapping("/todo/*")
public class TodoController {
	
	@Autowired
	private TodoService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1")int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			HttpServletRequest req,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String userId = info.getUserId();
		
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows = 5;
		int dataCount;
		int total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userId", userId);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page -1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
			
		List<Todo> list = service.listTodo(map);
		
		int listNum, n=0;
		for(Todo dto : list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			
		
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
		
		listUrl = cp + "/todo/list";
		articleUrl = cp + "/todo/article?page="+current_page;
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
		
		
		
	return  ".todo.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session ) throws Exception {
			
		model.addAttribute("mode", "write");
		return ".todo.write";
	}
 	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Todo dto, HttpSession session ) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "todo";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertTodo(dto, pathname);
		} catch (Exception e) {
		}				
		return "redirect:/todo/list";
	}
	
	 
	
	@RequestMapping(value = "article")
	public String article (
			@RequestParam int todoNum,
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
			query += "condition=" + condition+"keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		Todo dto = service.readTodo(todoNum);
		if(dto == null) {
			return "redirect:/todo/list?" + query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		String userId = info.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("todoNum", todoNum);
		map.put("userId", userId);
		
		
		
		Todo preReadDto = service.preReadTodo(map);
		Todo nextReadDto = service.nextReadTodo(map);
			
		List<Todo> listFile = service.listFile(todoNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("query", query);
		
		return ".todo.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update( 
			@RequestParam int todoNum,
			@RequestParam String page,
			Model model,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Todo dto = service.readTodo(todoNum);
		if(dto == null || ! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/todo/list?page="+page;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>").trim());
		
		List<Todo> listFile = service.listFile(todoNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("listFile", listFile);
		

		return ".todo.write";
	}
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit( 
			Todo dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "todo";
			
			dto.setUserId(info.getUserId());
			service.updateTodo(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/todo/list?page="+page;
		
	}
	
	@RequestMapping(value = "delete")
	public String delete(  
			@RequestParam int todoNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "")String keyword,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page=" +page;
		if(keyword.length()!=0) {
			query += "condition="+condition+"&keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "todo";
		
		service.deleteTodo(todoNum, pathname, info.getUserId());
			
		return "redirect:/todo/list?" + query;
	}
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int fileNum, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "todo";
		
		Todo dto = service.readFile(fileNum);
		if(dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("todoNum", fileNum);
		service.deleteFile(map);
		
		
		// 작업결과 Json으로 전송
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		
		return model;
	}
	
	@RequestMapping(value = "download")
	public void download(@RequestParam int fileNum, 
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "todo";
		
		boolean b = false;
		
		Todo dto = service.readFile(fileNum);
		if(dto != null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
			
		}
		if(! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다');history.back();</script>");				
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value = "zipdownload")
	public void zipdownload(@RequestParam int todoNum, 
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "todo";
		
		boolean b = false;
		
		List<Todo> listFile = service.listFile(todoNum);
		if(listFile.size() > 0) {
			String [] sources = new String[listFile.size()];
			String [] originals = new String[listFile.size()];
			String zipFilename = todoNum + ".zip";
			
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
				out.println("<script>alert('파일 다운로드가 불가능 합니다.');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	
			
}