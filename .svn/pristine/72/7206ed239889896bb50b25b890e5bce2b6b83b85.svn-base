package apm.modules.message.web;

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

import apm.modules.message.entity.Message;
import apm.modules.message.service.MessageService;

/**
 * 消息实体类Controller
 * @author gfp
 * @version 2015-09-08
 */
@Controller
@RequestMapping(value = "${adminPath}/message")
public class MessageController extends BaseController<MessageService, Message> {

	//注入其他的Service层或本层
	@Autowired
	private MessageService messageService;
	
	//返回到消息实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(Message message, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Message> page = service.find(new Page<Message>(request, response), message); 
        model.addAttribute("page", page);
        model.addAttribute("message", message);
		return "modules/message/messageList";
	}

	//返回到消息实体类表单页
	@RequestMapping(value = "form")
	public String form(Message message, Model model) {
		model.addAttribute("message", message);
		return "modules/message/messageForm";
	}
	
	//保存消息实体类信息，并返回到列表页
	@RequestMapping(value = "save")
	public String save(@Valid  Message message, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, message)){
			return form(message, model);
		}
		service.save(message);
		addMessage(redirectAttributes, "保存消息实体类'" + message.getId() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/message/list";
	}
	
	//根据ID删除消息实体类信息，并返回到列表页
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		service.delete(id);
		addMessage(redirectAttributes, "删除消息实体类成功");
		return "redirect:"+Global.getAdminPath()+"/message/list";
	}

}
