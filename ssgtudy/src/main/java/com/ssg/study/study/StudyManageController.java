package com.ssg.study.study;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("Study.studyManageController")
@RequestMapping("/studyManage/*")
public class StudyManageController {
	
	@RequestMapping(value = "all")
	public String managelist(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "studyName") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model,
			HttpSession session) throws Exception {
		
		
		
		return ".studyManage.managelist";
	}
}
