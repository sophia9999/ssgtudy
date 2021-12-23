package com.ssg.study.study;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("study.studyManageController")
@RequestMapping(value = "/studymanage/*")
public class StudyManageController {

	@Autowired
	private StudyService service;
	
}
