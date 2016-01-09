package apm.modules.program.web;

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

import apm.modules.program.entity.PublishProgramTimeSettings;
import apm.modules.program.service.PublishProgramTimeSettingsService;

/**
 * 发布节目时间段实体类Controller
 * @author gfp
 * @version 2015-09-06
 */
@Controller
@RequestMapping(value = "${adminPath}/publishProgramTimeSettings")
public class PublishProgramTimeSettingsController extends BaseController<PublishProgramTimeSettingsService, PublishProgramTimeSettings> {

	//注入其他的Service层或本层
	@Autowired
	private PublishProgramTimeSettingsService publishProgramTimeSettingsService;
	
	//返回到发布节目时间段实体类列表页，完成分页显示
	@RequiresPermissions("publishProgramTimeSettings:view")
	@RequestMapping(value = {"list", ""})
	public String list(PublishProgramTimeSettings publishProgramTimeSettings, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<PublishProgramTimeSettings> list = service.findAll();
		model.addAttribute("list", list);
		
        Page<PublishProgramTimeSettings> page = service.find(new Page<PublishProgramTimeSettings>(request, response), publishProgramTimeSettings); 
        model.addAttribute("page", page);
		return "modules/program/publishProgramTimeSettingsList";
	}

	//返回到发布节目时间段实体类表单页
	@RequiresPermissions("publishProgramTimeSettings:view")
	@RequestMapping(value = "form")
	public String form(PublishProgramTimeSettings publishProgramTimeSettings, Model model) {
		model.addAttribute("publishProgramTimeSettings", publishProgramTimeSettings);
		return "modules/program/publishProgramTimeSettingsForm";
	}
	
	//保存发布节目时间段实体类信息，并返回到列表页
	@RequiresPermissions("publishProgramTimeSettings:edit")
	@RequestMapping(value = "save")
	public String save(@Valid  PublishProgramTimeSettings publishProgramTimeSettings, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, publishProgramTimeSettings)){
			return form(publishProgramTimeSettings, model);
		}
		service.save(publishProgramTimeSettings);
		addMessage(redirectAttributes, "保存发布节目时间段实体类'" + publishProgramTimeSettings.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/publishProgramTimeSettings/list";
	}
	
	//根据ID删除发布节目时间段实体类信息，并返回到列表页
	@RequiresPermissions("publishProgramTimeSettings:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除发布节目时间段实体类成功");
		return "redirect:"+Global.getAdminPath()+"/publishProgramTimeSettings/list";
	}

}
