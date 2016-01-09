package apm.modules.terminal.web;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import apm.common.config.Global;
import apm.common.core.Page;
import apm.common.utils.JSONUtils;
import apm.common.utils.StringUtils;
import apm.common.web.BaseController;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import apm.modules.terminal.entity.OnOffModeTime;
import apm.modules.terminal.entity.ScreenShootTime;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalGroup;
import apm.modules.terminal.entity.TerminalSettings;
import apm.modules.terminal.service.TerminalGroupService;
import apm.modules.terminal.service.TerminalService;
import apm.modules.terminal.service.TerminalSettingsService;

/**
 * 终端设置实体类Controller
 * @author gfp
 * @version 2015-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/terminalSettings")
public class TerminalSettingsController extends BaseController<TerminalSettingsService, TerminalSettings> {

	//注入其他的Service层或本层
	@Autowired
	private TerminalSettingsService terminalSettingsService;

	//注入其他的Service层或本层
	@Autowired
	private TerminalService terminalService;
	
	//注入其他的Service层或本层
	@Autowired
	private TerminalGroupService terminalGroupService;		
	
	/**
	 * 用于JSON数据的构建
	 */
	private ObjectMapper mapper = new ObjectMapper();	
	//返回到终端设置实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(TerminalSettings terminalSettings, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<TerminalSettings> list = service.findAll();
		model.addAttribute("list", list);
		
        Page<TerminalSettings> page = service.find(new Page<TerminalSettings>(request, response), terminalSettings); 
        model.addAttribute("page", page);
        
        
		return "modules/terminal/terminalSettingsList";
	}

	//返回到终端设置实体类表单页
	@RequiresPermissions("terminalSettings:view")
	@RequestMapping(value = "form")
	public String form(TerminalSettings terminalSettings, Model model) {
		model.addAttribute("terminalSettings", terminalSettings);
		return "modules/terminal/terminalSettingsForm";
	}
	
	//保存终端设置实体类信息，并返回到列表页
	@RequiresPermissions("terminalSettings:edit")
	@RequestMapping(value = "save")
	public String save(@Valid  TerminalSettings terminalSettings, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, terminalSettings)){
			return form(terminalSettings, model);
		}
		service.save(terminalSettings);
		addMessage(redirectAttributes, "保存终端设置实体类'" + terminalSettings.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/terminalSettings/list";
	}
	
	//根据ID删除终端设置实体类信息，并返回到列表页
	@RequiresPermissions("terminalSettings:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除终端设置实体类成功");
		return "redirect:"+Global.getAdminPath()+"/terminalSettings/list";
	}
	
	//截屏页面
	@RequestMapping("screenShootPage")
	public String screenShootPage(Model model){
		initTerminalGroup(model);
		//查询定时截屏时间
        List<TerminalSettings> settings = service.findScreenShootTimes("47970fba4f61e5c0a8822");
		return "modules/terminal/terminalSettingsScreenShoot";
	}
	//定时开关页面
	@RequestMapping("onOffModePage")
	public String onOffModePage(Model model){
		initTerminalGroup(model);
		//查询定时截屏时间
        List<TerminalSettings> settings = service.findScreenShootTimes("47970fba4f61e5c0a8822");
		return "modules/terminal/terminalSettingsOnOffMode";
	}
	
	/**
	 * 初始化终端分组
	 * @param model
	 */
	private void initTerminalGroup(Model model) {

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
		
		
		
	}

	//保存截屏时间
	@ResponseBody
	@RequestMapping(value = "saveScreenShootTimes")
	public String saveScreenShootTimes(HttpServletRequest request) throws Exception {
		String fixedTimeFlag = request.getParameter("fixedTimeFlag"); //是否定时截屏
		String terminalIds = request.getParameter("terminalIds");
		List<String> ids = null;
		if(StringUtils.isNotEmpty(terminalIds)){
			ids = Arrays.asList(terminalIds.split(","));
		}else{
			return "failed";
		}
		if("0".equals(fixedTimeFlag)){	//否
			return  "failed";
		}else{							//定时截图
			String t1 = request.getParameter("t1");
			String t2 = request.getParameter("t2");
			String t3 = request.getParameter("t3");
			String t4 = request.getParameter("t4");
			String checked1 = request.getParameter("checked1");
			String checked2 = request.getParameter("checked2");
			String checked3 = request.getParameter("checked3");
			String checked4 = request.getParameter("checked4");
			ScreenShootTime s1 = new ScreenShootTime(t1, checked1);
			ScreenShootTime s2 = new ScreenShootTime(t2, checked2);
			ScreenShootTime s3 = new ScreenShootTime(t3, checked3);
			ScreenShootTime s4 = new ScreenShootTime(t4, checked4);
			List<ScreenShootTime> ss = new ArrayList<>();
			ss.add(s1);
			ss.add(s2);
			ss.add(s3);
			ss.add(s4);
			try{
				return service.saveScreenShootTimes(ss,ids);
			}catch(Exception e){
				e.printStackTrace();
				return "failed";
			}
		}
	}

	/**
	 * 保存开关机模式时间
	 * @param request
	 * @param mode 开机模式(0:每天，1：星期模式)
	 * @param modeSwitch 开关机控制（0：常开，1：定时）
	 * @param workTimes工作时间
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "saveOnOffModeTimes")
	public String saveOnOffModeTimes(HttpServletRequest request ) throws Exception {
		String mode = request.getParameter("mode");
		String modeSwitch = request.getParameter("modeSwitch");
		String terminalIds = request.getParameter("terminalIds");
		String weekMode = request.getParameter("weekMode");
		List<String> ids = null;
		if(StringUtils.isNotEmpty(terminalIds)){
			ids = Arrays.asList(terminalIds.split(","));
		}else{
			return "failed";
		}
		if("true".equals(weekMode)){			//星期模式
			String sun = request.getParameter("Sun");
			String mon = request.getParameter("Mon");
			String tue = request.getParameter("Tue");
			String wed = request.getParameter("Wed");
			String thurs = request.getParameter("Thurs");
			String fri = request.getParameter("Fri");
			String sat = request.getParameter("Sat");
			List<OnOffModeTime> sunList =  JSONUtils.json2list(sun, OnOffModeTime.class);
			List<OnOffModeTime> monList =  JSONUtils.json2list(mon, OnOffModeTime.class);
			List<OnOffModeTime> tueList =  JSONUtils.json2list(tue, OnOffModeTime.class);
			List<OnOffModeTime> wedList =  JSONUtils.json2list(wed, OnOffModeTime.class);
			List<OnOffModeTime> thursList =  JSONUtils.json2list(thurs, OnOffModeTime.class);
			List<OnOffModeTime> friList =  JSONUtils.json2list(fri, OnOffModeTime.class);
			List<OnOffModeTime> satList =  JSONUtils.json2list(sat, OnOffModeTime.class);
			
			List<List<OnOffModeTime>> times = new ArrayList<>();
			times.add(sunList);
			times.add(monList);
			times.add(tueList);
			times.add(wedList);
			times.add(thursList);
			times.add(friList);
			times.add(satList);
			return service.saveOnOffModeTimes(ids,mode,modeSwitch,null,times);
		}else{								//每天模式
			String workTimes = request.getParameter("workTimes");
			List<OnOffModeTime> everyDayModeWorkTimesList = null;
			if(request.getParameter("workTimes")!= null){
				everyDayModeWorkTimesList = JSONUtils.json2list(workTimes, OnOffModeTime.class);
			}
			return service.saveOnOffModeTimes(ids,mode,modeSwitch,everyDayModeWorkTimesList,null);
		}
	}
	
	
	/**
	 * 点击导航栏的格式化，响应此函数。
	 * @param model
	 * @return 左侧的终端分组信息，以及默认的未分组信息
	 */
	@RequestMapping(value = "format")
	public String format(Model model){

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
		
		return "modules/terminal/terminalFormat";
	}
	
	/**
	 * 
	 * doFormat:具体的格式化操作，发送命令到终端. <br/> 
	 * 	Ps：此函数已经能拿到页面中传来的需要格式化的终端Id，还没和Netty交互。
	 * @author whc 
	 * @param request
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "doFormat")
	public String doFormat(HttpServletRequest request) throws JsonProcessingException{
		Map map = new HashMap();
		
		String terminalIds = request.getParameter("terminalIds");
		
		String ids[] = terminalIds.split(",");
		
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
	
	
	/**
	 * 
	 * volumeSetting:点击导航栏的音量设置响应此函数. <br/> 
	 * 
	 * @author whc 
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "volumeSetting")
	public String volumeSetting(Model model){
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
		
		return "modules/terminal/terminalVolume";
	}
	
	
	/**
	 * 	doSetVolume:具体向终端设置音量的函数 <br/> 
	 * 	Ps：此函数已经能拿到页面中传来的需要格式化的终端Id，还没和Netty交互。
	 * @param request
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "doSetVolume")
	public String doSetVolume(HttpServletRequest request) throws JsonProcessingException{
		
		Map map = new HashMap();
		
		String terminalIds = request.getParameter("terminalIds");
		String alwaysVol = request.getParameter("alwaysVol");
		String timingVol1 = request.getParameter("timingVol1");
		String timingVol2 = request.getParameter("timingVol2");
		String timingVol3 = request.getParameter("timingVol3");
		String timingVol4 = request.getParameter("timingVol4");
		//时间
		String s1 = request.getParameter("s1");
		String e1 = request.getParameter("e1");
		String s2 = request.getParameter("s2");
		String e2 = request.getParameter("e2");
		String s3 = request.getParameter("s3");
		String e3 = request.getParameter("e3");
		String s4 = request.getParameter("s4");
		String e4 = request.getParameter("e4");
		
		//验证参数合理性
		if( (terminalIds == null) || (alwaysVol == null) || (timingVol1 == null)
				|| (timingVol2 == null)|| (timingVol3 == null)|| (timingVol4 == null) ){
			map.put("msg", "error");
			return mapper.writeValueAsString(map);
		}
			
		//alwaysVol：-1 表示 音量设置为定时；否则，设置为常开
		if(alwaysVol.equals("-1")){
			int _timingVol1 = Integer.parseInt(timingVol1);
			int _timingVol2 = Integer.parseInt(timingVol2);
			int _timingVol3 = Integer.parseInt(timingVol3);
			int _timingVol4 = Integer.parseInt(timingVol4);
		} else {
			int _alwaysVol = Integer.parseInt(alwaysVol);
		}
		
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
	
	
	/**
	 * 点击导航栏的亮度设置响应此函数. <br/> 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "brightSetting")
	public String brightSetting(Model model){
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
				
		return "modules/terminal/terminalBright";
	}
	
	/**
	 * 	doSetBright:具体向终端设置亮度的函数 <br/> 
	 * 	Ps：此函数已经能拿到页面中传来的需要格式化的终端Id，还没和Netty交互。
	 * @param request
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "doSetBright")
	public String doSetBright(HttpServletRequest request) throws JsonProcessingException{
		
		Map map = new HashMap();
		
		String terminalIds = request.getParameter("terminalIds");
		String alwaysBright = request.getParameter("alwaysBright");
		String timingBright1 = request.getParameter("timingBright1");
		String timingBright2 = request.getParameter("timingBright2");
		String timingBright3 = request.getParameter("timingBright3");
		String timingBright4 = request.getParameter("timingBright4");
		//时间
		String s1 = request.getParameter("s1");
		String e1 = request.getParameter("e1");
		String s2 = request.getParameter("s2");
		String e2 = request.getParameter("e2");
		String s3 = request.getParameter("s3");
		String e3 = request.getParameter("e3");
		String s4 = request.getParameter("s4");
		String e4 = request.getParameter("e4");
		
		//验证参数合理性
		if( (terminalIds == null) || (alwaysBright == null) || (timingBright1 == null)
				|| (timingBright2 == null)|| (timingBright3 == null)|| (timingBright4 == null) ){
			map.put("msg", "error");
			return mapper.writeValueAsString(map);
		}
			
		//alwaysVol：-1 表示 亮度设置为定时；否则，设置为常开
		if(alwaysBright.equals("-1")){
			int _timingBright1 = Integer.parseInt(timingBright1);
			int _timingBright2 = Integer.parseInt(timingBright2);
			int _timingBright3 = Integer.parseInt(timingBright3);
			int _timingBright4 = Integer.parseInt(timingBright4);
		} else {
			int _alwaysVol = Integer.parseInt(alwaysBright);
		}
		
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
}
