package com.ssg.study.notice;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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


@Controller("notice.noticeController")
@RequestMapping("/notice/*")
public class NoticeController {
	@Autowired
	private NoticeService service;
	
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
		
		List<Notice> list = service.listBoard(map);
		
		//리스트의 번호
		Date endDate = new Date();
		long gap;
		int listNum, n=0;
		for(Notice dto : list) {
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
		
		listUrl = cp + "/notice/list";
		articleUrl = cp + "/notice/article?page="+current_page;
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
		
		return ".notice.list";
	}
}
