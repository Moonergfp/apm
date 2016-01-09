/** 
 * Project Name:apm-web 
 * File Name:TerminalUpgradeController.java 
 * Package Name:apm.modules.terminal.web 
 * Date:2015年8月25日下午9:53:01 
 * Copyright (c) 2015, wuhuachuan712@163.com All Rights Reserved. 
 * 
 */   
      
package apm.modules.terminal.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import apm.common.core.Page;
import apm.common.utils.ApmUtils;
import apm.common.utils.JSONUtils;
import apm.common.web.BaseController;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.fileManage.service.FileInfosaService;
import apm.modules.sys.entity.Office;
import apm.modules.sys.service.OfficeService;
import apm.modules.sys.support.Users;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalGroup;
import apm.modules.terminal.service.TerminalGroupService;
import apm.modules.terminal.service.TerminalService;
import apm.modules.terminal.service.TerminalUpgradeService;

/** 
 * ClassName: TerminalUpgradeController <br/> 
 * Reason: TODO 在线升级模块Controller. <br/> 
 * date: 2015年8月25日 下午9:53:01 <br/> 
 * 
 * @author whc 
 * @version  1.0
 * @since JDK 1.8 
 */
@Controller
@RequestMapping(value = "${adminPath}/terminalUpgrade")
public class TerminalUpgradeController  extends BaseController<TerminalUpgradeService, Terminal>{
	
	//注入其他的Service层或本层
	@Autowired
	private TerminalUpgradeService terminalUpgradeService;
	
	//注入其他的Service层或本层
	@Autowired
	private TerminalService terminalService;
	
	//注入其他的Service层或本层
	@Autowired
	private TerminalGroupService terminalGroupService;
	
	//用于得到所有的机构
	@Autowired
	private OfficeService officeService;
	
	@Autowired
	private FileInfosaService fileInfosaService;
	
	/**
	 * 用于JSON数据的构建
	 */
	private ObjectMapper mapper = new ObjectMapper();		
	
	/**
	 * 
	 * upgrade:首次进入在线升级响应次函数. <br/> 
	 * 		1. 得到页面左侧分组信息 2.中间默认显示 未分组 的终端信息
	 * @author whc 
	 * @param model
	 * @return 1.0
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "upgrade")
	public String upgrade(Model model){
		
		//1. 得到分组信息并且返回
		List<TerminalGroup> terminalGroupList = terminalService.getTerminalGroupList();
		
		//得到所有终端的一个总数
		int num = terminalService.getTotalNum(terminalGroupList);
		
		//把未分组剔除出来单独返回，因为未分组具有一定的特殊性，比如需要置顶
		TerminalGroup unDividedGroup = terminalGroupService.removeUnDivideGroup(terminalGroupList);
		
		model.addAttribute("terminalGroupList", terminalGroupList);
		model.addAttribute("totalTerminalNum", num);
		model.addAttribute("unDividedGroup", unDividedGroup);
		model.addAttribute("terminalGroup", unDividedGroup);
		
		//2. 默认显示未分组终端信息
		List<Terminal> terminalList = unDividedGroup.getTerminals();
		model.addAttribute("terminalList", terminalList);
		
		return "modules/terminal/terminalUpgrade";
	}
	
	
	/**
	 * 
	 * getTerminalInfo_ajax:得到某个分组的终端信息. <br/> 
	 * 
	 * @author whc 
	 * @return 
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "getTerminalInfo_ajax")
	public String getTerminalInfo_ajax(HttpServletRequest request,HttpServletResponse response) throws JsonProcessingException{
		
		//构建返回信息
		Map<String, Object> map = new HashMap();
		String terminalGroup_id = request.getParameter("terminalGroup_id");
				
		//对 ID 进行验证
		if( (terminalGroup_id == null) || terminalGroup_id.length() != 21){
			map.put("msg","服务器出错了！");
			return mapper.writeValueAsString(map);
		}
		
		//返回该分组
		TerminalGroup terminalGroup =terminalGroupService.findById(terminalGroup_id);
		if(terminalGroup == null){
			map.put("msg","服务器出错了！");
			return mapper.writeValueAsString(map);
		}
		terminalGroup.setTerminalNum(terminalGroup.getTerminals().size());
		map.put("selectedTerminalGroup", terminalGroup);
		
		//返回该分组对应的终端信息
		Terminal terminal = new Terminal();
		terminal.setTerminalGroup(terminalGroup);
		Page<Terminal> page = terminalService.find(
				new Page<Terminal>(request, response),terminal); 
		map.put("terminalList", page.getList());
		
		map.put("msg","success");
		return mapper.writeValueAsString(map);
	}
	
	/**
	 * 
	 * getTerminalNewestVersion:得到最新的终端版本. <br/> 
	 * 
	 * @author whc 
	 * @return 返回最新的终端版本的字符串
	 * @throws Exception 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "getTerminalNewestVersion")
	public String getTerminalNewestVersion(HttpServletRequest request) throws Exception{
		
		Map map = new HashMap();
		
		//type = 1:系统升级;type = 0: APK升级。 
		String type = request.getParameter("type");
		String isManager = request.getParameter("isManager");
		
		//验证参数的合法性
		boolean valid = false;
		if( (type != null) && (type.equals(ApmUtils.getDictValue("apk_update_package")) || 
				type.equals(ApmUtils.getDictValue("sys_update_package"))))
				valid = true;
		
		if( (isManager != null) && (isManager.equals("true") || type.equals("false") )  )
			valid = true;
		
		if(valid == true){
			FileInfosa newestPackage = fileInfosaService
					.getTerminalNewestPackage(type);
			map.put("newestPackage", newestPackage);
			
			if( isManager.equals("true") ){
				map.put("officeList", officeService.findAll());
				map.put("msg", "success");
				return mapper.writeValueAsString(map);
			} else {
				//如果 普通用户 网络 APK升级，那么除了查找上行代码的系统公共版本，还要查找用户特定版本。
				FileInfosa customedNewestPackage = type.equals(ApmUtils.getDictValue("apk_update_package")) ?
					fileInfosaService.getTerminalNewestPackage(ApmUtils.getDictValue("customed_apk_update_package")) :
					fileInfosaService.getTerminalNewestPackage(ApmUtils.getDictValue("customed_sys_update_package"));
				map.put("customedNewestPackage",customedNewestPackage);
				map.put("msg", "success");
				return mapper.writeValueAsString(map);
			}
		}
				
		map.put("msg", "error");
		return mapper.writeValueAsString(map);
	}
	
	/**
	 * 具体的升级函数，需要向Netty 发信息
	 * Ps： 和Netty 这一步还没有做。
	 * @param request
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "concreteUpgrade")
	public String concreteUpgrade(HttpServletRequest request) throws JsonProcessingException{
		Map map = new HashMap();
		
		String firmware_apk = request.getParameter("firmware_apk");
		String sys_customed = request.getParameter("sys_customed");
		String terminalIds = request.getParameter("terminalIds");
		
		String ids[] = terminalIds.split(",");
		
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
}
  