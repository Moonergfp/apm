/**
 * Copyright &copy; 2012-2013 Zaric All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package apm.modules.sys.web;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import apm.common.config.Global;
import apm.common.utils.CacheUtils;
import apm.common.utils.CookieUtils;
import apm.common.utils.StringUtils;
import apm.common.web.AbstractController;
import apm.modules.sys.entity.User;
import apm.modules.sys.support.Users;

import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;

/**
 * 登录Controller
 * <p>@author zhangzuoqiang
 * @version 2013-5-31
 */
@Controller
public class LoginController extends AbstractController {
	
	/**
	 * 进入登录页面
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		 if(StringUtils.isNotEmpty(Users.currentUser().getId())){
			return "redirect:" + Global.getAdminPath();
		} 
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.POST)
	public String login(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username, HttpServletRequest request, HttpServletResponse response, Model model) {
		//model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
		//model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));
		//return "modules/sys/sysLogin";
		//登录失败,由于是异步传输只能跳转到异步方法中在传输到界面中,由于未登录存在权限只能走f路径
		return "redirect:" + Global.getFrontPath() + "/login_result?flag=false";
	}

	/**
	 * 登录成功，进入管理首页
	 */
	@RequiresUser
	@RequestMapping(value = "${adminPath}")
	public String index(HttpServletRequest request, HttpServletResponse response) {
		//登录标致位,主要用来判断是否是由登录页面输入信息进入,从session中获取
		HttpSession session = request.getSession();
		String loginFlag = (String) session.getAttribute(session.getId()+"loginFlag");
		User user = Users.currentUser();
		//清空session的标志
		session.removeAttribute(session.getId()+"loginFlag");
		//存在标志位且不存在用户
		if(StringUtils.isNotBlank(loginFlag)){
			//异步登录成功,跳转到异步方法中,传参true
			return "redirect:" + Global.getFrontPath() + "/login_result?flag=true";
		} 
		//返回登录页
		if(user.getId() == null){
			return "redirect:" + Global.getAdminPath() + "/login";
		} 
		// 验证码计算器清零
		isValidateCodeLogin(user.getLoginName(), false, true);
		return "modules/sys/sysIndex";
	}
	
	//异步传输,加入该方法用来向页面输出返回值,由于未登录存在权限只能走f路径
	@ResponseBody
	@RequestMapping(value="${frontPath}/login_result")
	public String loginResult(HttpServletRequest req){
		//直接返回是否已成功登录
		return req.getParameter("flag");
	}
	
	//进入首页
	
	/**
	 * 获取主题方案
	 */
	@RequestMapping(value = "/theme/{theme}")
	public String getThemeInCookie(@PathVariable String theme, HttpServletRequest request, HttpServletResponse response){
		if (StringUtils.isNotBlank(theme)){
			CookieUtils.setCookie(response, "theme", theme);
		}else{
			theme = CookieUtils.getCookie(request, "theme");
		}
		return "redirect:"+request.getParameter("url");
	}
	
	/**
	 * 是否是验证码登录
	 * @param useruame 用户名
	 * @param isFail 计数加1
	 * @param clean 计数清零
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean){
		Map<String, Integer> loginFailMap = (Map<String, Integer>)CacheUtils.get("loginFailMap");
		if (loginFailMap==null){
			loginFailMap = Maps.newHashMap();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum==null){
			loginFailNum = 0;
		}
		if (isFail){
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean){
			loginFailMap.remove(useruame);
		}
		return loginFailNum >= 3;
	}
	
}