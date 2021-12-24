package com.ssg.study.study;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("Study.studyManageController")
@RequestMapping("/studyManage/*")
public class StudyManageController {
	
	@RequestMapping(value = "all")
	public String managelist() throws Exception {
		
		return ".studyManage.managelist";
	}
}
