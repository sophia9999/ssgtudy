package com.ssg.study.admin;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("admin.controller")
@RequestMapping("admin/*")
public class AdminController {
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home() {
		
		return ".admin.main";
	}
}
