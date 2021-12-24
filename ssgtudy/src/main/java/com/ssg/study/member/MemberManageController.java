package com.ssg.study.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;






@Controller("member.memberManageController")
@RequestMapping(value = "/membermanage/*")
public class MemberManageController {
	@Autowired
	private MemberService service;

	@RequestMapping("/manager")
	public String main(Model model) {
		
		List<Member> list = null;
		
		try {
			list = service.readAdmin();
		} catch (Exception e) {
		}
		
		model.addAttribute("adminlist", list);
		
		return ".admin.main";
	}
	
	@RequestMapping(value="findAdmin" ,method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> findAdmin(String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Member dto = null;
		try {			
			dto = service.findAdmin(userId);
		} catch (Exception e) {
		}
		
		map.put("vo", dto);
		
		return map;
	}
	
	@RequestMapping(value="updateAdmin" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateAdmin(String userId,int membership) {
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "false";
		Member dto = null;
		try {			
			map.put("membership", membership);
			map.put("userId", userId);
			
			service.updateAdmin(map);
			result = "true";
			dto = service.findAdmin(userId);
			
			
		} catch (Exception e) {
		}
		
		model.put("admin", dto);
		model.put("result", result);
		
		return model;
	}
	
	@RequestMapping("/user")
	public String user(Model model) {
		
		
		return ".admin.memberManage.user";
	}
	
	@RequestMapping(value="stateCodelist" ,method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> stateCodelist(
					@RequestParam(defaultValue = "") String keyword			
					,@RequestParam(defaultValue = "10")String row
					,@RequestParam(defaultValue = "1")String pageNum) {
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		List<Member> list = null;
		try {
			Integer dataCount = service.readCnt(keyword); // 49 
			int rows = Integer.parseInt(row);
			int pageNums = Integer.parseInt(pageNum);
			
			int start = rows*(pageNums-1)+1;
			int end = rows*pageNums;
			
			int totalPage = dataCount/rows;  
			totalPage = dataCount%rows==0? totalPage+0: totalPage+1;						
			
			map.put("start", start);
			map.put("end",end );
			map.put("keyword", keyword);
			list = service.readStateCode(map);
			model.put("row", row);
			model.put("totalPage", totalPage);
			model.put("now", pageNums);
			
		} catch (Exception e) {
		}
		
		model.put("list", list);
		
		return model;
	}
	
	@RequestMapping(value="updateStateCode" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateStateCode(String userId,String stateCode) {
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "false";
		Integer state = Integer.parseInt(stateCode);
		try {
			
			map.put("stateCode", state);
			map.put("userId", userId);
			
			service.updateStateCode(map);
			result = "true";
		
		} catch (Exception e) {
		}
		
		model.put("state", state);
		model.put("result", result);
		
		return model;
	}
	
}
