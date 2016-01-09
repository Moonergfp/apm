package ${packageName}.${moduleName}.web${subModuleName};

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

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};
import ${packageName}.${moduleName}.service${subModuleName}.${ClassName}Service;

/**
 * ${functionName}Controller
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Controller
@RequestMapping(value = "${r"${adminPath}"}${urlPrefix}")
public class ${ClassName}Controller extends BaseController<${ClassName}Service, ${ClassName}> {

	//注入其他的Service层或本层
	@Autowired
	private ${ClassName}Service ${className}Service;
	
	//返回到${functionName}列表页，完成分页显示
	@RequiresPermissions("${permissionPrefix}:view")
	@RequestMapping(value = {"list", ""})
	public String list(${ClassName} ${className}, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<${ClassName}> list = service.findAll();
		model.addAttribute("list", list);
		
        Page<${ClassName}> page = service.find(new Page<${ClassName}>(request, response), ${className}); 
        model.addAttribute("page", page);
		return "${returnPrefix}List";
	}

	//返回到${functionName}表单页
	@RequiresPermissions("${permissionPrefix}:view")
	@RequestMapping(value = "form")
	public String form(${ClassName} ${className}, Model model) {
		model.addAttribute("${className}", ${className});
		return "${returnPrefix}Form";
	}
	
	//保存${functionName}信息，并返回到列表页
	@RequiresPermissions("${permissionPrefix}:edit")
	@RequestMapping(value = "save")
	public String save(@Valid  ${ClassName} ${className}, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ${className})){
			return form(${className}, model);
		}
		service.save(${className});
		addMessage(redirectAttributes, "保存${functionName}'" + ${className}.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"${viewPrefix}/list";
	}
	
	//根据ID删除${functionName}信息，并返回到列表页
	@RequiresPermissions("${permissionPrefix}:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除${functionName}成功");
		return "redirect:"+Global.getAdminPath()+"${viewPrefix}/list";
	}

}
