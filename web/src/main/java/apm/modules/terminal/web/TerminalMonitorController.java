package apm.modules.terminal.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.hibernate.mapping.Array;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import apm.common.config.Global;
import apm.common.core.Page;
import apm.common.utils.ApmUtils;
import apm.common.web.BaseController;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.program.entity.Program;
import apm.modules.program.service.ProgramService;
import apm.modules.sys.entity.Menu;
import apm.modules.sys.service.MenuService;
import apm.modules.sys.support.Users;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalGroup;
import apm.modules.terminal.entity.TerminalInfo;
import apm.modules.terminal.entity.TerminalSettings;
import apm.modules.terminal.service.TerminalGroupService;
import apm.modules.terminal.service.TerminalService;
import apm.modules.terminal.service.TerminalSettingsService;

/**
 * 终端监控实体类Controller
 * @author gfp
 * @version 2015-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/terminalMonitor")
public class TerminalMonitorController extends BaseController<TerminalService, Terminal> {

	//注入其他的Service层或本层
	@Autowired
	private TerminalService terminalService;
	@Autowired
	private TerminalGroupService terminalGroupService;
	@Autowired
	private TerminalSettingsService terminalSettingsService;
	@Autowired
	private ProgramService programService;
	@Autowired
	private MenuService menuService;
	
	
	//返回到节目实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(Terminal terminal, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Terminal> list = service.findAll();
		model.addAttribute("list", list);
		
        Page<Terminal> page = service.find(new Page<Terminal>(request, response), terminal); 
        model.addAttribute("page", page);
		return "modules/terminal/terminalMonitor";
	}

	//返回到节目实体类表单页
	@RequestMapping(value = "form")
	public String form(Terminal terminal, Model model) {
		model.addAttribute("terminal", terminal);
		return "modules/terminal/terminalForm";
	}
	
	//保存节目实体类信息，并返回到列表页
	@RequestMapping(value = "save")
	public String save(@Valid  Terminal terminal, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, terminal)){
			return form(terminal, model);
		}
		service.save(terminal);
		addMessage(redirectAttributes, "保存节目实体类'" + terminal.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/terminal/list";
	}
	
	//根据ID删除节目实体类信息，并返回到列表页
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除节目实体类成功");
		return "redirect:"+Global.getAdminPath()+"/terminal/list";
	}


	/**
	 * 终端控制页面
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "monitor")
	public String showMain(Terminal terminal,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		//1.查询终端分组
		List<TerminalGroup> terminalGroupList = terminalService.getTerminalGroupList();
		int totalNum = terminalService.getTotalNum(terminalGroupList);
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("terminalGroupList", terminalGroupList);
		//2.获取一个终端
		List<Terminal> ts = null;
		if(terminal != null && terminal.getId() != null){
			
		}else{
			//2.获取未分组第一个终端的实时截屏图片、status、内存情况
			for(TerminalGroup group : terminalGroupList ){
				if("未分组".equals(group.getName())){
					ts = group.getTerminals();//获取未分组内的所有终端
					if(ts.size() == 0){
						terminal = terminalService.findAll(Users.currentUser().getCompany().getId()).get(0);  //获取任意一个终端
					}else{
						terminal = ts.get(0);  //获取未分组第一个终端
					}
				    break;
				}
			}
		}
		//3.查询该终端工作时间
		List<String> workTime = terminalSettingsService.findWorkTime(terminal);
		//4.查询终端所有截屏并为截屏转换图片路径
		List<FileInfosa>  screenShoots = terminalSettingsService.findScreenShoots(terminal);
		FileInfosa screenShoot = null;
		if(screenShoots.size() > 0){
			screenShoot = screenShoots.get(0);
		}else{
			screenShoot = new FileInfosa();
			screenShoot.setPath("/apm-web/static/images/terminal/screen.jpg");
		}
		//5.获取终端节目列表 (测试数据)
		/*List<Program> pros = terminal.getPrograms();*/
		List<Program> pros = new ArrayList<>();
		Program p1 = new Program();
		p1.setId("123");
		p1.setName("倚天屠龙记");
		Program p2 = new Program();
		p2.setId("456");
		p2.setName("樱桃小丸子");
		Program p3 = new Program();
		p3.setId("789");
		p3.setName("纪念反法西斯胜利70周年公益广告");
		pros.add(p1);
		pros.add(p2);
		pros.add(p3);
		
		model.addAttribute("fisrtTerminal", terminal); 	 	  //终端
		model.addAttribute("screenShoots", screenShoots); 	 //终端截屏
		model.addAttribute("pros", pros); 					 //终端节目列表
		model.addAttribute("screenShoot", screenShoot); 	 //终端最新截屏
		model.addAttribute("workTime",workTime);		 //终端的工作时间 
		model.addAttribute("unDividedGroupTers", ts); 	//未分组内的终端
		return "modules/terminal/terminalMonitor";
	}

	/**
	 * 查询终端信息（状态，内存等情况）
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("getTerminalInfo")
	public TerminalInfo getTerminalInfo(Terminal terminal) throws Exception{
		TerminalInfo info = terminalSettingsService.sendTerminalInfoReq2Netty(terminal);  //获取终端信息
		return info;
	}
	
	/**
	 * 查询终端
	 * @param groupId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("findTerminals")
	public List<Terminal> findTerminals(Terminal terminal,HttpServletRequest request, HttpServletResponse response, Model model){
		//得到未分组的终端信息(以分页的形式)
		Page<Terminal> page = terminalService.find(
				new Page<Terminal>(request, response),terminal); 
		 List<Terminal> ls = page.getList();
		return ls;
	}

	/**
	 * 查看终端截屏时间轴
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("fixedTimeAxis")
	public String fixedTimeAxis(Terminal terminal,Model model) throws ParseException{
		List<FileInfosa>  screenShoots = terminalSettingsService.findScreenShoots(terminal);  //获取所有截屏
		Comparator imgCom = new Comparator<FileInfosa>(){	//定时图片文件排序器，按照时间从小到大排序
			public int compare(FileInfosa o1, FileInfosa o2) {
				return o1.getCreateDate().compareTo(o2.getCreateDate());
			}
		};
		for(FileInfosa f : screenShoots){
			f.setPath((ApmUtils.downLoadPath(f.getPath())));
		}
		TreeMap<Integer, TreeMap<Date,List<FileInfosa>>> times = new TreeMap<>(new Comparator<Integer>(){  
			public int compare(Integer o1, Integer o2) {
				int num =  o1.compareTo(o2);
				if(num == -1){
					return 1;
				}
				if(num == 1){
					return -1;
				}
				return 0;
			}     
        });
		for(int i = 0 ; i < screenShoots.size(); i++){
			FileInfosa file = screenShoots.get(i);
			Date d = file.getCreateDate();
			Calendar c = Calendar.getInstance();
			c.setTime(d);
			int year = c.get(Calendar.YEAR);
			int	month = c.get(Calendar.MONTH);
			int day = c.get(Calendar.DATE);
			Calendar c2 = Calendar.getInstance();  //月日
			Date d2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("1970-1-1 00:00:00");
			c2.setTime(d2);
			c2.set(Calendar.YEAR, year);
			c2.set(Calendar.MONTH, month);
			c2.set(Calendar.DATE, day);
			Date monthDate = c2.getTime();
			List<FileInfosa> imgUrls = null;
			TreeMap<Date,List<FileInfosa>> monthDateMap = null;
			if(times.get(year) == null){	//新一年
				 monthDateMap  = new TreeMap<>(new Comparator<Date>(){
					public int compare(Date o1, Date o2) {
						int num =  o1.compareTo(o2);
						if(num == -1){
							return 1;
						}
						if(num == 1){
							return -1;
						}
						return 0;
					}
				});
				imgUrls = new ArrayList<>();
				
			}else{
				monthDateMap = times.get(year);
				if(monthDateMap.get(monthDate) == null){		//新的一个月/日
					imgUrls = new ArrayList<>();
				}else{
					imgUrls = monthDateMap.get(monthDate);
				}
			}
			imgUrls.add(file);
			Collections.sort(imgUrls,imgCom);
			monthDateMap.put(monthDate, imgUrls);
			times.put(year, monthDateMap);
		}
		model.addAttribute("times", times);
		return "modules/terminal/fixedTimeAxis";
	}
	
	/**
	 * 向netty发送调节音量命令
	 * @param num 音量
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("sendVoiceReq2Netty")
	public String sendVoiceReq2Netty(TerminalSettings terminalSettings,HttpServletRequest request) throws Exception{
		terminalSettingsService.sendVoiceReq2Netty(terminalSettings);
		return "modules/terminal/fixedTimeAxis";
	}
	
	/**
	 * 向netty发送开机/关机/重启命令
	 * @param num 音量
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("sendTerminalStatusReq2Netty")
	public String sendTerminalStatusReq2Netty(Terminal terminal,String type,HttpServletRequest request) throws Exception{
		return terminalSettingsService.sendTerminalStatusReq2Netty(terminal,type);
	}
	
	/**
	 * 向netty发送截屏命令
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("sendScreenShootReq2Netty")
	public String sendScreenShootReq2Netty(Terminal terminal,HttpServletRequest request){
		try{
			return terminalSettingsService.sendScreenShootReq2Netty(terminal);
		}catch(Exception e){
			e.printStackTrace();
			return "failed";
		}
	}
	
	/**
	 * 获取实时截图
	 * @param terminalId终端ID
	 * @param time前端获取实时截图的系统时间
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("getScreenShoot")
	public String getScreenShoot(String terminalId,String time){
		System.out.println("time===>" + time);
		return terminalSettingsService.getScreenShoot(terminalId,time);
	}
}
