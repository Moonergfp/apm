/** 
 * Project Name:apm-web 
 * File Name:Resource.java 
 * Package Name:apm.modules.resource.web 
 * Date:2015年9月6日下午2:41:30 
 * Copyright (c) 2015, wuhuachuan712@163.com All Rights Reserved. 
 * 
 */   
      
package apm.modules.resource.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import apm.common.utils.ApmUtils;
import apm.modules.sys.entity.Dict;
import apm.modules.sys.service.DictService;

/** 
 * ClassName: Resource <br/> 
 * Reason: TODO 素材管理controller. <br/> 
 * date: 2015年9月6日 下午2:41:30 <br/> 
 * 
 * @author whc 
 * @version  1.0
 * @since JDK 1.8 
 */
@Controller
@RequestMapping(value = "${adminPath}/resManage")
public class ResManageController {
	
	@Autowired
	private DictService dictService;
	
	/**
	 * 用于JSON数据的构建
	 */
	private ObjectMapper mapper = new ObjectMapper();
	
	
	/**
	 * 
	 * myRes:点击一级导航的素材管理响应次函数. <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @param model
	 * @return 
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "myRes")
	public String myRes(HttpServletRequest request,Model model){
		
		//得到左侧素材类别（并且把英文的一些显示改成中文）
		model.addAttribute("dictList", 
				transfer( ApmUtils.getDictValues("resource") ));
		
		return "modules/resManage/resList";
		
	}

	/** 
	 * transfer:把英文名字的类别转化为中文名字. <br/> 
	 * 
	 * @author whc 
	 * @param list
	 * @return 
	 * @since JDK 1.8 
	 */  
	private List<Dict> transfer(List<Dict> list) {
		for(int i = 0; i < list.size(); ++i){
			Dict dict = list.get(i);
			switch (dict.getValue()) {
				case "background":{
					dict.setChineseName("背景");
					break;
				}
				case "rss":{
					dict.setChineseName("RSS");
					break;
				}
				case "excel":{
					dict.setChineseName("EXCEL");
					break;
				}
				case "word":{
					dict.setChineseName("WORD");
					break;
				}
				case "ppt":{
					dict.setChineseName("PPT");
					break;
				}
				case "music":{
					dict.setChineseName("音乐");
					break;
				}
				case "video":{
					dict.setChineseName("视频");
					break;
				}
				case "img":{
					dict.setChineseName("图片");
					break;
				}
				default:{
					dict.setChineseName(dict.getValue());
					break;
				}
			}
		}
		
		//判断每个大分类是否有子文件夹
		setIfHasSubFolder(list); 
		
		return list;
	}
	
	/** 
	 * setIfHasSubFolder:判断每个大分类是否有子文件夹. <br/> 
	 * 
	 * @author whc 
	 * @param list 
	 * @since JDK 1.8 
	 */  
	private void setIfHasSubFolder(List<Dict> list) {
		for (Dict dict : list) {
			String d = dictService.get(dict.getId()).getValue();
			if(ApmUtils.getDictValues(dictService.get(dict.getId()).getValue()).size() == 0){
				dict.setHasSubFolder(false);
			} else {
				List<Dict> l = ApmUtils.getDictValues(dictService.get(dict.getId()).getValue());
				dict.setHasSubFolder(true);
			}
		}
	}

	/**
	 * 
	 * getFolders:得到某个类别的子文件夹. <br/> 
	 * 
	 * @author whc 
	 * @param request
	 * @return
	 * @throws JsonProcessingException 
	 * @since JDK 1.8
	 */
	@ResponseBody
	@RequestMapping(value = "getFolders")
	public String getFolders(HttpServletRequest request) throws JsonProcessingException{
		
		Map map = new HashMap();
		
		String dictId = request.getParameter("dictId");
		
		//验证ID有效性
		if( (dictId == null) || (dictId.length() != 21)){
			map.put("msg", "error");
			return mapper.writeValueAsString(map);
		}
		
		map.put("dictList",transfer(ApmUtils.getDictValues(dictService.get(dictId).getValue())));
		map.put("msg", "success");
		
		return mapper.writeValueAsString(map);
	}
	
	
	
}
  