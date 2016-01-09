package apm.modules.terminal.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import apm.common.config.Global;
import apm.common.core.Page;
import apm.common.utils.StringUtils;
import apm.common.web.BaseController;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Strings;

import apm.modules.sys.entity.Log;
import apm.modules.sys.entity.Office;
import apm.modules.sys.entity.User;
import apm.modules.sys.support.Users;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalGroup;
import apm.modules.terminal.service.TerminalGroupService;
import apm.modules.terminal.service.TerminalService;

/**
 * 终端实体类Controller
 * @author gfp
 * @version 2015-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/terminal")
public class TerminalController extends BaseController<TerminalService, Terminal> {

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
	
	//返回到节目实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(Terminal terminal, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Terminal> list = service.findAll();
		model.addAttribute("list", list);
		
        Page<Terminal> page = service.find(new Page<Terminal>(request, response), terminal); 
        model.addAttribute("page", page);
		return "modules/terminal/terminalList";
	}

	//返回到节目实体类表单页
	@RequiresPermissions("terminal:view")
	@RequestMapping(value = "form")
	public String form(Terminal terminal, Model model) {
		model.addAttribute("terminal", terminal);
		return "modules/terminal/terminalForm";
	}
	
	//保存节目实体类信息，并返回到列表页
	@RequiresPermissions("terminal:edit")
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
	@RequiresPermissions("terminal:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除节目实体类成功");
		return "redirect:"+Global.getAdminPath()+"/terminal/list";
	}

	
	
	
	
	/**
	 * 返回到节目实体类列表页，完成分页显示
	 * info:点击终端信息,响应此函数 <br/> 
	 * 
	 * 功能：根据页面需要得到 1.得到分组信息 2.总共的终端数量  3.在分组列表中去除 未分组 这一项，未分组这项单独返回（因为未分组始终需要置顶，并且
     *       	不能出现修改，删除 等按钮，具有特殊性）4.得到未分组的终端列表（默认第一次进入查找未分组），返回分页信息
	 * 
	 * Ps:注意：首次进入终端信息进入此函数，后面点击终端分组，或者终端删除等功能不再响应此函数
	 *    	因为一开始写的时候未考虑到合并一起，后面加入这些功能的时候为了逻辑分开点就重写了函数 
	 * @author whc 
	 * @param terminal
	 * @param request
	 * @param response
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequestMapping(value = {"info/list", "info"})
	public String info(Terminal terminal, HttpServletRequest request, 
			HttpServletResponse response, Model model) {

		// 1.得到全部分组信息
		List<TerminalGroup> terminalGroupList = terminalService.getTerminalGroupList();
		
		// 2.得到总共有多少个终端
		model.addAttribute("totalTerminalNum", terminalService.getTotalNum(terminalGroupList));
		
		// 3.去除未分组这一项fixedBackgroundColorElement
		TerminalGroup unDivideGroup = terminalGroupService.removeUnDivideGroup(terminalGroupList);
		model.addAttribute("terminalGroupList", terminalGroupList);
		model.addAttribute("unDivideGroup", unDivideGroup);
		//在删除终端的时候，前端根据 selectedTerminalGroup.name == '未分组' 判断是否要设置未分组的背景色，
		//在删除终端的方法中，也会返回一个selectedTerminalGroup，为了这两者统一，虽然和上述的 unDividedGroup一样，也需要设置
		model.addAttribute("selectedTerminalGroup", unDivideGroup);
		
		// 4.得到未分组的终端信息(以分页的形式)
		terminal.setTerminalGroup(unDivideGroup);
		Page<Terminal> page = terminalService.find(
				new Page<Terminal>(request, response),terminal); 
		model.addAttribute("terminalList", page.getList());
		model.addAttribute("page", page);
		
		return "modules/terminal/terminalList";
	}
	
	
	/**
	 * 
	 * addNewGroup:Ajax形式保存新的终端分组. <br/> 
	 * 
	 * @author whc 
	 * @param request --只需传入新的分组名字
	 * @return  返回 1.该新的分组的 json 数据 2. msg:success 表示 保存成功；否则 msg 表示错误信息
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "addNewGroup")
	public String addNewGroup(HttpServletRequest request) throws JsonProcessingException{
		
		//构建返回信息
		Map map = new HashMap();
		
		//验证页面传来的新分组名字的合法性,以及判断是否已经存在
		String newGroupName = request.getParameter("newGroupName");
		if(newGroupName.isEmpty()) map.put("msg", "新分组名字不能为空");
		if(newGroupName.length() > 21) map.put("msg", "新分组名字最长为21字符");
		
		String idIfExist = terminalGroupService.newGroupNameIsExist(newGroupName);
		if(!idIfExist.isEmpty() ) {
			map.put("msg", "新分组名字已经存在");
		}
		if(map.size() > 0) return mapper.writeValueAsString(map);

		//验证成功，则保存分组名字
		TerminalGroup terminalGroup = new TerminalGroup();
		terminalGroup.setOffice(Users.currentUser().getCompany());
		terminalGroup.setName(newGroupName);
		TerminalGroup _terminalGroup = terminalGroupService.saveAndReturnSavedEntity(terminalGroup);
		
		map.put("terminalGroup", _terminalGroup);
		map.put("msg", "success");
		
		return mapper.writeValueAsString(map);
	}
	
	
	/**
	 * 
	 * getTerminalInfo_ajax:点击某一个终端分组，得到终端信息. <br/> 
	 * 
	 * @author whc 
	 * @param request -- 只需传入 该分组的 id 信息
	 * @param response
	 * @return msg：success 表示成功；否则表示 错误信息 ； 返回该分组的信息，以及该组对应的终端信息（JSON）
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "getTerminalInfo_ajax")
	public String getTerminalInfo_ajax(HttpServletRequest request,HttpServletResponse response) 
			throws JsonProcessingException{
		
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
		map.put("page", page.pageString());
		
		map.put("msg","success");
		return mapper.writeValueAsString(map);
	}
	
	
	/**
	 * 
	 * deleteGroup:删除终端分组. <br/> 
	 * 
	 * @author whc 
	 * @param terminalGroup
	 * @param terminal
	 * @param request -- 只需传入该分组的 ID
	 * @param response
	 * @param model
	 * @return 利用 info 函数，删除后相当于重新进入 终端管理
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "deleteGroup")
	public String deleteGroup(HttpServletRequest request, 
			HttpServletResponse response, Model model){
		
		//验证terminalGroupID的合法性
		String id = request.getParameter("id");
		if( (id == null) || (id.length() != 21))
			return "error/400";
		
		//得到 该分组 以及 未分组
		TerminalGroup terminalGroup = terminalGroupService.findById(id);
		TerminalGroup unDividedGroup = terminalGroupService.findByNameAndTenand_id("未分组",
				Users.currentUser().getCompany().getId());
		
		//把该分组下的全部终端转到未分组中
		List<Terminal> terminalList = terminalGroup.getTerminals();
		Iterator<Terminal> it = terminalList.iterator();
		Terminal terminal = new Terminal();
		while(it.hasNext()){
			terminal = it.next();
			terminal.setTerminalGroup(unDividedGroup);
		}
		
		//删除该分组
		terminalGroupService.delete(terminalGroup.getId());
		
		return info(terminal, request, response, model);
	}
	
	
	/**
	 * 
	 * modifyGroupName:修改分组的名字. <br/> 
	 * 
	 * @author whc 
	 * @param terminalGroup -- 该分组的 id 和名字自动封装到了该对象中
	 * @return msg：error && warn：success 表示 成功。（因为如果用户什么都不填，就相当于一个刷新的功能，
	 * 			后面需要在前端修改，不让用户请求过来，现在暂时还未优化）
	 * 		   msg：success 表示修改成功
	 * 		   msg：error && warn ！= success 表示修改失败。此时的warn 表示错误信息
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "modifyGroupName")
	public String modifyGroupName(TerminalGroup terminalGroup) throws JsonProcessingException{
		
		Map map = new HashMap();
		
		//验证ID 和 Name的合理性
		if( (terminalGroup.getId() == null) || (terminalGroup.getId().length() != 21) ||
			(terminalGroup.getName() == null) || (terminalGroup.getName().isEmpty()) ||
			(terminalGroup.getName().length() > 21) ){
			map.put("warn", "服务器出错，暂时无法操作");
			map.put("msg", "error");
			return mapper.writeValueAsString(map);
		}
		
		//判断修改的名字是否存在，如果存在，则会返回存在的实体的id；如果不存在，则返回为空
		String idIfExist = terminalGroupService.newGroupNameIsExist(terminalGroup.getName());
		if(!idIfExist.isEmpty() ) {
			map.put("msg", "error");
			if(idIfExist.equals(terminalGroup.getId())){
				//如果相同，必然是自己修改自己，比如 123 修改成123，前台JS已经判断是不会传过来
				map.put("warn", "服务器出错，暂时无法操作");
				return mapper.writeValueAsString(map); 
			}
			map.put("warn", "新分组名字已经存在");
			return mapper.writeValueAsString(map); 
		}
		
		//修改分组
		TerminalGroup _TerminalGroup = terminalGroupService.findById(terminalGroup.getId());
		_TerminalGroup.setName(terminalGroup.getName());
		terminalGroupService.save(_TerminalGroup);
		
		map.put("msg", "success");
		return mapper.writeValueAsString(map);
	}
	
	
	/**
	 * 
	 * delete_terminal:删除终端. <br/> 
	 * 功能： 1.删除终端。
	 * 		2.返回信息（和 info 基本一致） 包括：
	 * 			1. 得到分组信息 
	 * 			2.总共的终端数量  
	 * 			3.在分组列表中去除 未分组 这一项，未分组这项单独返回（因为未分组始终需要置顶，并且
     *       		不能出现修改，删除 等按钮，具有特殊性）
     *       	4.返回该分组下信息
     *       	5.返回该分组下的终端信息
	 * 
	 * @author whc 
	 * @param request
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "delete_terminal")
	public String delete_terminal(HttpServletRequest request,
			HttpServletResponse response, Model model) throws JsonProcessingException{
		
		//对需要删除的终端id，以及该分组的id进行验证
		String delete_id = request.getParameter("delete_id");
		String terminalGroup_id = request.getParameter("terminalGroup_id");
		
		if( (delete_id != null) && (delete_id.length() == 21) ) ;
		else return "error/400";
		if( (terminalGroup_id != null) && (terminalGroup_id.length() == 21) ) ;
		else return "error/400";
		
		//验证成功，进行删除操作
		terminalService.delete(delete_id);
		
		//1. 得到全部分组信息
		List<TerminalGroup> terminalGroupList = terminalService.getTerminalGroupList();
		
		//2. 得到总共有多少个终端
		model.addAttribute("totalTerminalNum", terminalService.getTotalNum(terminalGroupList));
		
		//3. 在分组列表中去除 未分组 这一项，未分组这项单独返回
		TerminalGroup unDivideGroup = terminalGroupService.removeUnDivideGroup(terminalGroupList);
		model.addAttribute("terminalGroupList", terminalGroupList);
		model.addAttribute("unDivideGroup", unDivideGroup);
		
		//4. 返回该分组信息
		TerminalGroup terminalGroup = terminalGroupService.findById(terminalGroup_id);
		model.addAttribute("selectedTerminalGroup", terminalGroup);
		if(terminalGroup == null) return "error/400";
		
		//5. 返回该分组下的终端信息
		Terminal terminal = new Terminal();
		terminal.setTerminalGroup(terminalGroup);
		Page<Terminal> page = terminalService.find(
			new Page<Terminal>(request, response),terminal); 
		model.addAttribute("terminalList", page.getList());
		model.addAttribute("page", page.pageString());

		return "modules/terminal/terminalList";
	}
	
	
	/**
	 * 
	 * transferTerminal:对终端进行转存. <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @param response
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "transferTerminal")
	public String transferTerminal(HttpServletRequest request,HttpServletResponse response,Model model){
		
		String idArray = request.getParameter("idArray");
		String groupId = request.getParameter("groupId");
		String ids[] = idArray.split(","); 
		
		//验证 id， groupId的 合法性
		boolean valid = validData(ids,groupId);
		if(valid == false) return "error/400";
		
		//把终端转存,如果返回-1 表示转存失败
		if(terminalService.transferTerminal(ids,groupId) == -1 )
			return "error/400";
		
		//返回信息
		//1. 得到全部分组信息
		List<TerminalGroup> terminalGroupList = terminalService.getTerminalGroupList();
				
		//2. 得到总共有多少个终端
		model.addAttribute("totalTerminalNum", terminalService.getTotalNum(terminalGroupList));
				
		//3. 在分组列表中去除 未分组 这一项，未分组这项单独返回
		TerminalGroup unDivideGroup = terminalGroupService.removeUnDivideGroup(terminalGroupList);
		
		model.addAttribute("terminalGroupList", terminalGroupList);
		model.addAttribute("unDivideGroup", unDivideGroup);
				
		//4. 返回该分组信息
		TerminalGroup terminalGroup = terminalGroupService.findById(groupId);
		model.addAttribute("selectedTerminalGroup", terminalGroup);
		if(terminalGroup == null) return "error/400";
				
		//5. 返回该分组下的终端信息
		Terminal terminal = new Terminal();
		terminal.setTerminalGroup(terminalGroup);
		Page<Terminal> page = terminalService.find(
			new Page<Terminal>(request, response),terminal); 
		model.addAttribute("terminalList", page.getList());
		model.addAttribute("page", page.pageString());

		return "modules/terminal/terminalList";
	}

	/** 
	 * validData:验证移动终端功能传来的终端id组合groupId的合法性. <br/> 
	 * 
	 * @author whc 
	 * @param ids
	 * @param groupId
	 * @return 
	 * @since JDK 1.8 
	 */  
	private boolean validData(String[] ids, String groupId) {
		
		for(int i = 0; i < ids.length; ++i){
			if((ids[i] != null) && ids[i].length() == 21) ;
			else return false;
		}
		
		if( (groupId != null) && (groupId.length() == 21) ) ;
		else return false;
		
		return true;
	}
}
