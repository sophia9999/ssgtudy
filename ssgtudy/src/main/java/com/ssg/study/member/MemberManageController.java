package com.ssg.study.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public Map<String, Object> stateCodelist(String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Member> list = null;
		try {			
			list = service.readStateCode();
		} catch (Exception e) {
		}
		
		map.put("list", list);
		
		return map;
	}
	
	@RequestMapping(value="updateStateCode" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateStateCode(String userId,int stateCode) {
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "false";
		try {			
			map.put("stateCode", stateCode);
			map.put("userId", userId);
			
			service.updateStateCode(map);
			result = "true";
		
		} catch (Exception e) {
		}
		
		
		model.put("result", result);
		
		return model;
	}
	
}
