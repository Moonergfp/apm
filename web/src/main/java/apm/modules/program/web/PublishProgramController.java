package apm.modules.program.web;

import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import apm.modules.program.entity.PublishProgram;
import apm.modules.program.service.PublishProgramService;

/**
 * 节目发布实体类Controller
 * @author gfp
 * @version 2015-09-06
 */
@Controller
@RequestMapping(value = "${adminPath}/publishProgram")
public class PublishProgramController extends BaseController<PublishProgramService, PublishProgram> {

	//注入其他的Service层或本层
	@Autowired
	private PublishProgramService publishProgramService;
	
	//返回到节目发布实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(PublishProgram publishProgram, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PublishProgram> page = service.find(new Page<PublishProgram>(request, response), publishProgram); 
        model.addAttribute("page", page);
        model.addAttribute("publishProgram", publishProgram);
		return "modules/program/publishRecordList";
	}

	//返回到节目发布实体类表单页
	@RequiresPermissions("publishProgram:view")
	@RequestMapping(value = "form")
	public String form(PublishProgram publishProgram, Model model) {
		model.addAttribute("publishProgram", publishProgram);
		return "modules/program/publishProgramForm";
	}
	
	//保存节目发布实体类信息，并返回到列表页
	@RequiresPermissions("publishProgram:edit")
	@RequestMapping(value = "save")
	public String save(@Valid  PublishProgram publishProgram, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, publishProgram)){
			return form(publishProgram, model);
		}
		service.save(publishProgram);
		addMessage(redirectAttributes, "保存节目发布实体类'" + publishProgram.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/publishProgram/list";
	}
	
	//根据ID删除节目发布实体类信息，并返回到列表页
	@RequiresPermissions("publishProgram:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除节目发布实体类成功");
		return "redirect:"+Global.getAdminPath()+"/publishProgram/list";
	}
	
	//节目审核列表
	@RequestMapping(value = "checklist")
	public String checklist(PublishProgram publishProgram, HttpServletRequest request, HttpServletResponse response, Model model){
	/*	List<PublishProgram> pubPros = service.findPubPros();*/
		System.out.println(" 查询审核列表");
		Page<PublishProgram> page  = service.findPubPros(new Page<PublishProgram>(request, response),publishProgram); 
	    model.addAttribute("page", page);
	    model.addAttribute("pubPros",page.getList());
	    if(StringUtils.isNotEmpty(publishProgram.getCheckStatus())){
	    	 model.addAttribute("checkStatus",publishProgram.getCheckStatus());
	    }
		return "modules/program/checkProgram";
	}
	//节目审核列表
	@ResponseBody
	@RequestMapping(value = "checkPubPro")
	public String checkPubPro(PublishProgram pubPro,Model model) {
		try{
			service.checkPubPro(pubPro);
			return "ok";
		}catch(Exception e){
			return "failed";
		}
	}
	
}
