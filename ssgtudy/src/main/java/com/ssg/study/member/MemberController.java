package com.ssg.study.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


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

		// 세션에 로그인 정보 저장
		SessionInfo info = new SessionInfo();
		
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getNickName());

		session.setMaxInactiveInterval(30 * 60); // 세션유지시간 30분, 기본:30분

		session.setAttribute("member", info);

		// 로그인 이전 URI로 이동 -> 나중에 손 봐야할 부분
		String uri = (String) session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if (uri == null) {
			uri = "redirect:/";
		} else {
			// uri = "redirect:" + uri;
			uri = "redirect:/";
		}

		return uri;
	}


}
