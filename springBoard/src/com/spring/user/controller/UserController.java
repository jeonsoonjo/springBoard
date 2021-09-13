package com.spring.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.vo.ComCodeVo;
import com.spring.common.CommonUtil;
import com.spring.user.service.userService;
import com.spring.user.vo.UserVo;

@Controller
public class UserController {
	
	@Autowired 
	userService userService;
	
	// 아이디 중복체크
	@RequestMapping(value = "/user/idCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(Locale locale, Model model, UserVo userVo) throws Exception{
		int result = userService.idCheck(userVo);
		return result;
	}
	
	// 회원가입 페이지
	@RequestMapping(value = "/user/userJoin.do", method = RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception{
		
		// 코드타입 데이터 select 출력(phone)
		List<ComCodeVo> phoneList = new ArrayList<ComCodeVo>();
		phoneList = userService.phoneList();
		model.addAttribute("phoneList", phoneList);
		
		return "user/userJoin";
	}

	// 회원가입
	@RequestMapping(value = "/user/userJoinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoinAction(Locale locale, Model model, UserVo userVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = userService.userJoin(userVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	// 로그인 페이지
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) throws Exception{
		return "user/userLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/user/userLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public int userLoginAction(HttpSession session, Locale locale, Model model, UserVo userVo) throws Exception{
		
		UserVo userInfo = userService.userLogin(userVo);
		
		int result = 0 ;
		if(userInfo != null) {
			// 아이디와 비번이 일치하는 값이 있을 경우, session에 등록
			session.setAttribute("userInfo", userInfo);
			result = 1;
		} else {
			session.setAttribute("userInfo", null);
			result = 0;
		}
		
		return result;
	}
	
	// 로그아웃
	@RequestMapping(value = "/user/userLogout.do", method = RequestMethod.GET)
	public String userLogout(HttpSession session, Locale locale, Model model) throws Exception{
		// session 비우기
		session.invalidate();
		return "redirect:/";
	}
}
