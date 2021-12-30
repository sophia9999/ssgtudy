package com.ssg.study.communitySch;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.member.SessionInfo;

@Controller("communitySch.scheduleController")
@RequestMapping("/communitySch/*")
public class ScheduleController {
	@Autowired
	private ScheduleService service;
	
	@RequestMapping(value = "main")
	public String main() throws Exception {
		
		return ".communitySch.main";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(
			@ModelAttribute(value = "dto") Schedule dto,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if (info.getMembership() < 51) {
			
			return "redirect:/communitySch/main";
		}
		
		model.addAttribute("mode", "write");
		
		return ".communitySch.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Schedule dto,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			if(info.getMembership() > 50) {
				
				service.insertSchedule(dto);
			}
		} catch (Exception e) {
		}
		
		return "redirect:/communitySch/main";
	}
	
	@RequestMapping(value="month")
	@ResponseBody
	public Map<String, Object> month(
			@RequestParam String start,
			@RequestParam String end,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Integer schoolCode = info.getSchoolCode();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("schoolCode", schoolCode);
		
		List<Schedule> list = service.listMonth(map);
		
		for(Schedule dto : list) {
			if(dto.getStartTime()==null) {
				dto.setAllDay(true);
			} else {
				dto.setAllDay(false);
			}
			
			if(dto.getStartTime()!=null && dto.getStartTime().length()!=0) {
				dto.setStart(dto.getStartDate()+"T"+dto.getStartTime());
			} else {
				dto.setStart(dto.getStartDate());
			}
			
			if(dto.getEndTime()!=null && dto.getEndTime().length()!=0) {
	    		dto.setEnd(dto.getEndDate()+"T" + dto.getEndTime());
	    	} else {
	    		dto.setEnd(dto.getEndDate());
	    	}
			
			if(dto.getRepeat()!=0) {
				if(dto.getStart().substring(0, 4).compareTo(start.substring(0, 4))!=0) {
					dto.setStart(start.substring(0, 4)+dto.getStart().substring(5));
				}
			}
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("list", list);
		return model;
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int scheduleNum,
			Model model) throws Exception {
		
		Schedule dto = service.readSchedule(scheduleNum);
		if(dto == null) {
			return "redirect:/communitySch/main";
		}
		
		if(dto.getStartTime() == null) {
			dto.setAll_day("1");
			try {
				String s = dto.getEndDate().replaceAll("\\-|\\.|/", "");

				int y = Integer.parseInt(s.substring(0, 4));
				int m = Integer.parseInt(s.substring(4, 6));
				int d = Integer.parseInt(s.substring(6));

				Calendar cal = Calendar.getInstance();
				cal.set(y, m - 1, d);

				cal.add(Calendar.DATE, -1);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				dto.setEndDate( sdf.format(cal.getTime()) );
			} catch (Exception e) {
			}
		}
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".communitySch.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Schedule dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			if(info.getMembership() > 50) {
				service.updateSchedule(dto);
			}
		} catch (Exception e) {
		}
		
		return "redirect:/communitySch/main";
	}

	// 일정을 드래그 한 경우 수정 완료 - AJAX : JSON
	@RequestMapping(value = "updateDrag", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateDragSubmit(Schedule dto, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		try {
			if(info.getMembership() > 50) {
				// 반복일정은 종료날짜등이 수정되지 않도록 설정
				if(dto.getRepeat() == 1 && dto.getRepeat_cycle() != 0) {
					dto.setEndDate("");
					dto.setStartTime("");
					dto.setEndTime("");
				}
				
			service.updateSchedule(dto);
			}
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	// 일정 삭제 - AJAX : JSON
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int scheduleNum,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		String state = "true";
		try {
			if(info.getMembership() > 50) {
			Map<String, Object> map=new HashMap<>();
			map.put("scheduleNum", scheduleNum);
			service.deleteSchedule(map);
			}
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
}
