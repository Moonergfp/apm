package apm.modules.terminal.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import apm.modules.terminal.entity.TerminalGroup;
import apm.modules.terminal.service.TerminalGroupService;

/**
 * 节目实体类Controller
 * @author gfp
 * @version 2015-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/terminalGroup")
public class TerminalGroupController extends BaseController<TerminalGroupService, TerminalGroup> {

	//注入其他的Service层或本层
	@Autowired
	private TerminalGroupService terminalGroupService;
	
	//返回到节目实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(TerminalGroup terminalGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<TerminalGroup> list = service.findAll();
		model.addAttribute("list", list);
		
        Page<TerminalGroup> page = service.find(new Page<TerminalGroup>(request, response), terminalGroup); 
        model.addAttribute("page", page);
		return "modules/terminal/terminalGroupList";
	}

	//返回到节目实体类表单页
	@RequestMapping(value = "form")
	public String form(TerminalGroup terminalGroup, Model model) {
		model.addAttribute("terminalGroup", terminalGroup);
		return "modules/terminal/terminalGroupForm";
	}
	
	//保存节目实体类信息，并返回到列表页
	@RequestMapping(value = "save")
	public String save(@Valid  TerminalGroup terminalGroup, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, terminalGroup)){
			return form(terminalGroup, model);
		}
		service.save(terminalGroup);
		addMessage(redirectAttributes, "保存节目实体类'" + terminalGroup.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/terminalGroup/list";
	}
	
	//根据ID删除节目实体类信息，并返回到列表页
	@RequiresPermissions("terminalGroup:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除节目实体类成功");
		return "redirect:"+Global.getAdminPath()+"/terminalGroup/list";
	}

}
