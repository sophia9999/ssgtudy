package com.ssg.study.todo;

import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.MyUtil;

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
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows = 5;
		int dataCount;
		int total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(condition, condition);
		map.put("keyword", keyword);
		
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
		
		// 리스트 번호
		Date endDate = new Date();
		long gap;
		int listNum, n=0;
		
			
	
		
		
		
		
			
	return  ".todo.list";
	}
}