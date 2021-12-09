package com.ssg.study.calendar;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("calendar.Controller")
@RequestMapping(value="/calendar/*")
public class CalendarController {
	
	@RequestMapping(value = "test", method = RequestMethod.GET)
	public String testForm() {
		return ".calendar.test";
	}

}
