package com.ssg.study.msg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("my.msgController")
@RequestMapping(value = "/msg/*")
public class MsgController {

	@Autowired
	private MsgService service;
	
	@RequestMapping(value = "receive")
	public String receive() throws Exception {
		
		return ".msg.receive";
	}
}
