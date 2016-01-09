/**
 * Copyright &copy; 2012-2013 Zaric All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package apm.modules.sys.web;


import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;

import apm.common.beanvalidator.BeanValidators;
import apm.common.config.Global;
import apm.common.core.Page;
import apm.common.upload.FileModel;
import apm.common.upload.FileRepository;
import apm.common.utils.AM;
import apm.common.utils.DateUtils;
import apm.common.utils.StringUtils;
import apm.common.utils.excel.ExportExcel;
import apm.common.utils.excel.ImportExcel;
import apm.common.web.BaseController;
import apm.modules.sys.entity.Role;
import apm.modules.sys.entity.User;
import apm.modules.sys.service.RoleService;
import apm.modules.sys.service.UserService;
import apm.modules.sys.support.Users;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;

/**
 * 用户Controller
 * <p>@author zhangzuoqiang
 * @version 2013-5-31
 */
@Controller
@RequestMapping(value = UserController.MODULE_PATH)
public class UserController extends BaseController<UserService, User> {
	
	// 模块页面根路径
	public static final String MODULE_PATH = "${adminPath}/sys/user";
	
	/**
	 * 用于JSON数据的构建
	 */
	private ObjectMapper mapper = new ObjectMapper();

	@Autowired
	private RoleService roleService;
	
	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = {"list", ""})
	public String list(User user, HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
        
		//得到用户数据
		Page<User> page = service.findUser(new Page<User>(request, response), user); 
        model.addAttribute("page", page);
        
        
        
        //根据角色 对User进行过滤（如果需要过滤的话，不需要则不会有roleId，不影响正常使用）
        String roleId = request.getParameter("roleId");
        
        if( (roleId != null) && (!roleId.equals("")) ){
	        boolean existRole = false;
	        List<User> userList = page.getList();
	        for(int i = 0; i < userList.size(); ++i){
	        	
	        	List roleList = userList.get(i).getRoleIdList();
	        	
	        	for(int j = 0; j < roleList.size(); ++j){
	        		if(roleId.equals(roleList.get(j))){
	        			existRole = true;
	        			break;
	        		}
	        	}
	        	if(!existRole){
	        		page.getList().remove(i);
	        		i--;
	        	}
	        	
	        	existRole = false;
	        }
        }
        
        //得到该用户所能看到的角色
        List<Role> roleList = roleService.findAll();
        model.addAttribute("roleList", roleList);
        return "modules/sys/userManage/userList";
//        return "modules/sys/userList";
	}
	

	@RequiresPermissions("sys:user:view")
	@RequestMapping(value = "form")
	public String form(User user, Model model) {
		model.addAttribute("user", user);
		model.addAttribute("allRoles", roleService.findAllRole());
//		return "modules/sys/userForm";
		return "modules/sys/userManage/userForm";
	}

	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "save")
	public String save(@Valid User user, String oldLoginName, String newPassword, Model model, RedirectAttributes redirectAttributes) {
		// 如果新密码为空，则不更换密码
		if (StringUtils.isNotBlank(newPassword)) {
			user.setPassword(Users.entryptPassword(newPassword));
		}
		if (!beanValidator(model, user)){
			return form(user, model);
		}
		if (!"true".equals(checkLoginName(oldLoginName, user.getLoginName()))){
			addMessage(model, AM.rs("sys_user_save_failure", user.getLoginName()));
			return form(user, model);
		}
		/*if(user.getCompany() != null && user.getOffice() == null){  	//将当前部门设置为当前公司
			user.setOffice(user.getCompany());
		}*/
		// 角色数据有效性验证，过滤不在授权内的角色
		Set<Role> roleList = Sets.newHashSet();
		List<String> roleIdList = user.getRoleIdList();
		for (Role r : roleService.findAllRole()){
			if (roleIdList.contains(r.getId())){
				roleList.add(r);
			}
		}
		user.setRoleList(roleList);
		// 保存用户信息
		service.saveUser(user);
			
		// 如果是用户自己改自己的，则清除当前自己的缓存，下次读取就可以拿到最新值
		if (user.getLoginName().equals(Users.currentUser().getLoginName())){
			Users.clearCache();
		}
			
		addMessage(redirectAttributes, AM.rs("sys_user_save_success", user.getLoginName()));
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}
	
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		if (Users.currentUser().getId().equals(id)){
			addMessage(redirectAttributes, AM.rs("sys_user_delete_self"));
		}else if (User.isAdmin(id)){
			addMessage(redirectAttributes, AM.rs("sys_user_delete_root"));
		}else{
			service.deleteUser(id);
			addMessage(redirectAttributes, AM.rs("sys_user_delete_success"));
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}
	
	@RequiresPermissions("sys:user:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(User user, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = AM.rs("sys_user_export_file_name", DateUtils.getDate("yyyyMMddHHmmss"));
    		Page<User> page = service.findUser(new Page<User>(request, response, -1), user); 
    		new ExportExcel(AM.rs("sys_user_export_file_suffix"), User.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, AM.rs("sys_user_export_failure", e.getMessage()));
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
    }

	@RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, Model model, RedirectAttributes redirectAttributes) {
		// 文件为空
		if (null == file || 0 == file.getSize()) {
			addMessage(redirectAttributes, AM.rs("sys_user_import_failure"));
		} else {
			try {
				int successNum = 0;
				int failureNum = 0;
				StringBuilder failureMsg = new StringBuilder();
				ImportExcel ei = new ImportExcel(file, 1, 0);
				List<User> list = ei.getDataList(User.class);
				for (User user : list){
					try{
						if ("true".equals(checkLoginName("", user.getLoginName()))){
							user.setPassword(Users.entryptPassword("123456"));
							BeanValidators.validateWithException(validator, user);
							service.saveUser(user);
							successNum++;
						}else{
							failureMsg.append(AM.rs("sys_user_import_user_is_exists", user.getLoginName()));
							failureNum++;
						}
					}catch(ConstraintViolationException ex){
						failureMsg.append(AM.rs("sys_user_import_user_failure", user.getLoginName(), ""));
						List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
						for (String message : messageList){
							failureMsg.append(message+"; ");
							failureNum++;
						}
					}catch (Exception ex) {
						failureMsg.append(AM.rs("sys_user_import_user_failure", user.getLoginName(), ex.getMessage()));
					}
				}
				if (failureNum>0){
					failureMsg.insert(0, AM.rs("sys_user_import_user_failure_count", failureNum));
				}
				addMessage(redirectAttributes, AM.rs("sys_user_import_user_success_count", successNum, failureMsg));
			} catch (Exception e) {
				addMessage(redirectAttributes, AM.rs("sys_user_import_failures", e.getMessage()));
			}
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
    }
	
	@RequiresPermissions("sys:user:view")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = AM.rs("sys_user_import_file_name");
    		List<User> list = Lists.newArrayList(); list.add(Users.currentUser());
    		new ExportExcel(AM.rs("sys_user_file_title"), User.class, 2).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, AM.rs("sys_user_import_failure", e.getMessage()));
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
    }

	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "checkLoginName")
	public String checkLoginName(String oldLoginName, String loginName) {
		if (loginName !=null && loginName.equals(oldLoginName)) {
			return "true";
		} else if (loginName !=null && service.findByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}

	@RequiresUser
	@RequestMapping(value = "info")
	public String info(User user, Model model) {
		User currentUser = Users.currentUser();
		if (StringUtils.isNotBlank(user.getName())){
			currentUser = Users.getUser(true);
			currentUser.setEmail(user.getEmail());
			currentUser.setPhone(user.getPhone());
			currentUser.setMobile(user.getMobile());
			currentUser.setRemarks(user.getRemarks());
			service.saveUser(currentUser);
			model.addAttribute("message", AM.rs("sys_user_save_success", currentUser.getLoginName()));
		}
		model.addAttribute("user", currentUser);
		return "modules/sys/personalMsg/userInfo";
	}

	@RequiresUser
	@RequestMapping(value = "modifyPwd")
	public String modifyPwd(String oldPassword, String newPassword, Model model) {
		User user = Users.currentUser();
		if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
			if (Users.validatePassword(oldPassword, user.getPassword())){
				service.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
				model.addAttribute("message", AM.rs("sys_user_modify_pwd_success"));
			}else{
				model.addAttribute("message", AM.rs("sys_user_modify_pwd_failure"));
			}
		}
		model.addAttribute("user", user);
//		return "modules/sys/userModifyPwd";
		return "modules/sys/userManage/userModifyPwd";
	}
	
	/**
	 * 头像上传
	 */
	@ResponseBody
	@RequestMapping("o_upload")
	public FileModel execute(HttpServletRequest request, HttpServletResponse response, ModelMap model) {

		String folder = request.getParameter("folder");
		CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());

		commonsMultipartResolver.setDefaultEncoding("utf-8");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("Filedata");
		FileModel fileModel = fileRepository.storeByExt(file, folder);
		return fileModel;
	}
	
	/**
	 * 在applicationContext.xml 已注入
	 */
	@Autowired
	private FileRepository fileRepository;
	
	
	
	
	
	
	
	
	
	
	
	//==========================apm 新增方法
	/**
	 * 
	 * updateLoginName:系统管理-个人中心-修改用户名（相当于昵称，不是登录名字）. <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @param model
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "updateLoginName")
	public String updateLoginName(HttpServletRequest request, Model model) throws JsonProcessingException {
		User currentUser = Users.currentUser();
		
		if (StringUtils.isNotBlank(request.getParameter("newName"))){
			currentUser = Users.getUser(true);
			currentUser.setName(request.getParameter("newName"));
			service.saveUser(currentUser);
			model.addAttribute("message", AM.rs("sys_user_save_success", currentUser.getLoginName()));
		}
		
		Map map = new HashMap();
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
	
	/**
	 * 
	 * updateEmail:系统管理-个人中心-修改邮箱  <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @param model
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "updateEmail")
	public String updateEmail(HttpServletRequest request, Model model) throws JsonProcessingException {
		User currentUser = Users.currentUser();
		
		if (StringUtils.isNotBlank(request.getParameter("newEmail"))){
			currentUser = Users.getUser(true);
			currentUser.setEmail(request.getParameter("newEmail"));
			service.saveUser(currentUser);
			model.addAttribute("message", AM.rs("sys_user_save_success", currentUser.getLoginName()));
		}
		
		Map map = new HashMap();
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}

	/**
	 * 
	 * updatePhone:系统管理-个人中心-修改电话 <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @param model
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "updatePhone")
	public String updatePhone(HttpServletRequest request, Model model) throws JsonProcessingException {
		User currentUser = Users.currentUser();
		
		if (StringUtils.isNotBlank(request.getParameter("newPhone"))){
			currentUser = Users.getUser(true);
			currentUser.setPhone(request.getParameter("newPhone"));
			service.saveUser(currentUser);
			model.addAttribute("message", AM.rs("sys_user_save_success", currentUser.getLoginName()));
		}
		
		Map map = new HashMap();
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
	
	/**
	 * 
	 * updateRemark:系统管理-个人中心-修改备注. <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @param model
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "updateRemark")
	public String updateRemark(HttpServletRequest request, Model model) throws JsonProcessingException {
		User currentUser = Users.currentUser();
		
		if (StringUtils.isNotBlank(request.getParameter("newRemark"))){
			currentUser = Users.getUser(true);
			currentUser.setRemarks(request.getParameter("newRemark"));
			service.saveUser(currentUser);
			model.addAttribute("message", AM.rs("sys_user_save_success", currentUser.getLoginName()));
		}
		
		Map map = new HashMap();
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
	
	/**
	 * 
	 * updatePwd:更新用户自己的密码. <br/> 
	 * 
	 * @author whc 
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "updatePwd")
	public String updatePwd(String oldPassword, String newPassword) throws JsonProcessingException{
	
		//原因是连改两次密码不会清除缓存
		Users.clearCache();
		
		Map map = new HashMap();
		
		User user = Users.currentUser();
		if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
			if (Users.validatePassword(oldPassword, user.getPassword())){
				service.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
				map.put("msg", "success");
				return mapper.writeValueAsString(map);
			}
		}
		
		map.put("msg", "error");
		return mapper.writeValueAsString(map);
 	}
}
