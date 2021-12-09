package com.ssg.study.member;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;




@Controller("member.memberController")
@RequestMapping(value = "/member/*")
public class MemberController {
	@Autowired
	private MemberService service;

	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm() {
		return "/member/login";
	}
	
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginSubmit(@RequestParam String userId,
			@RequestParam String userPwd,
			HttpSession session,
			Model model) {

		Member dto = service.loginMember(userId);
		if (dto == null || !userPwd.equals(dto.getPwd())) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "/member/login";
		} 
		
		try { // 로그인 후 최근 로그인 일자 업데이트
			service.updateLastLogin(dto.getUserId());
		} catch (Exception e) {
		}
		

		// 세션에 로그인 정보 저장
		SessionInfo info = new SessionInfo();
		
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		info.setNickName(dto.getNickName());
		info.setMembership(dto.getMembership());
		// 1은 일반회원 / 99는 관리자

		session.setMaxInactiveInterval(30 * 60); // 세션유지시간 30분, 기본:30분

		session.setAttribute("member", info);

		// 로그인 이전 URI로 이동 -> 나중에 손 봐야할 부분
		String uri = (String) session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if (uri == null) {
			uri = "redirect:/";
		} else {
			uri = "redirect:" + uri;
			// uri = "redirect:/";
		}

		return uri;
	}

	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		// 세션에 저장된 정보 지우기
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();

		return "redirect:/";
	}
	
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String joinForm(Model model) {
		
		
		List<Map<String, String>> list = null;
		try {
			list = service.readSchool();
		} catch (Exception e) {
			
		}
		model.addAttribute("mode", "join");
		model.addAttribute("list", list);
		return "/member/member";
	}
	
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String joinForm(Member dto,
							RedirectAttributes reattr) {
		
		try {
			dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
			dto.setTel(dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3());
			
			service.insertMember(dto);
		} catch (Exception e) {			
		}
		reattr.addFlashAttribute("mode", "join");
		return "redirect:/member/complete";
	}
	
	
	@RequestMapping(value = "userIdck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam String userId) throws Exception {
		
		String idck = "null";
		try {
			Member dto = service.readMember(userId); 
			if (dto != null) {
				idck = "Nonull";
			}
		} catch (Exception e) {
		}
		Map<String, Object> map = new HashMap<>();
		map.put("idck", idck);
		return map;
	}
	
	@RequestMapping(value = "complete")
		public String completeForm(@ModelAttribute("mode") String mode) {
			if(mode == null)return "redirect:/";
			
			return "/member/complete";
		}
	
}
