package com.ssg.study.my;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("my.myController")
@RequestMapping(value = "/my/*")
public class MyController {
	@Autowired
	private MyService service;
	
	@RequestMapping(value = "list")
	public String list() throws Exception {
		
		return ".my.list";
	}
}
