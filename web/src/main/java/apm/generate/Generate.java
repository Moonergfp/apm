/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package apm.generate;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Map;

import apm.common.utils.DateUtils;
import apm.common.utils.FileUtils;
import apm.common.utils.FreeMarkers;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;

import com.google.common.collect.Maps;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 代码生成器
 * @author 何堂冬
 * @version 2014-6-5 下午9:57:12 
 */
public class Generate {
	
	private static Logger logger = LoggerFactory.getLogger(Generate.class);

	public static void parameters(String packageName,String moduleName,String className,
			String classAuthor,String functionName,String tableName,String entityContent,String flag) throws Exception {
		// ========== ↓↓↓↓↓↓ 执行前请修改参数，谨慎执行。↓↓↓↓↓↓ ====================
		// 主要提供基本功能模块代码生成。
		// 目录生成结构：{packageName}/{moduleName}/{dao,entity,service,web}/{subModuleName}/{className}
		// packageName 包名，这里如果更改包名，请在applicationContext.xml和srping-mvc.xml中配置base-package、packagesToScan属性，来指定多个（共4处需要修改）。
		
		//String packageName = "lms.modules";//保存在包名
		
		//String moduleName = "test";			//模块名，例：sys
		String subModuleName = "";		// 子模块名（可选，作为扩展，一般不用） 
		//String className = "test";			// 类名，例：user
		//String classAuthor = "htd";			// 类作者，例：ThinkGem
		//String functionName = "测试";			//功能名，例：用户

		// 是否启用生成工具
		Boolean isEnable = true;			
		
		// ========== ↑↑↑↑↑↑ 执行前请修改参数，谨慎执行。↑↑↑↑↑↑ ====================
		
		if (!isEnable){
			//logger.error("请启用代码生成工具，设置参数：isEnable = true");
			System.out.println("请启用代码生成工具，设置参数：isEnable = true");
			return;
		}
		
		if (StringUtils.isBlank(moduleName) || StringUtils.isBlank(moduleName) 
				|| StringUtils.isBlank(className) || StringUtils.isBlank(functionName)){
			//logger.error("参数设置错误：包名、模块名、类名、功能名不能为空。");
			System.out.println("参数设置错误：包名、模块名、类名、功能名不能为空。");
			return;
		}
		
		// 获取文件分隔符
		String separator = File.separator;
		
		// 获取工程路径
		File projectPath = new DefaultResourceLoader().getResource("").getFile();
		while(!new File(projectPath.getPath()+separator+"src"+separator+"main").exists()){
			projectPath = projectPath.getParentFile();
		}
		//logger.info("Project Path: {}", projectPath);
		System.out.println("-------------------------项目相关路径------------------------");
		System.out.println("工程路径:"+projectPath);
		// 模板文件路径
		String tplPath = StringUtils.replace(projectPath+"/src/main/java/apm/generate/template", "/", separator);
		//logger.info("Template Path: {}", tplPath);
		System.out.println("模板文件路径:"+tplPath);
		// Java文件路径
		String javaPath = StringUtils.replaceEach(projectPath+"/src/main/java/"+StringUtils.lowerCase(packageName), 
				new String[]{"/", "."}, new String[]{separator, separator});
		//logger.info("Java Path: {}", javaPath);
		System.out.println("Java文件路径:"+javaPath);
		// 视图文件路径
		String viewPath = StringUtils.replace(projectPath+"/src/main/webapp/WEB-INF/views", "/", separator);
		//logger.info("View Path: {}", viewPath);
		System.out.println("视图文件路径:"+viewPath);
		// 代码模板配置
		Configuration cfg = new Configuration();
		cfg.setDirectoryForTemplateLoading(new File(tplPath));

		// 定义模板变量
		Map<String, String> model = Maps.newHashMap();
		model.put("packageName", StringUtils.lowerCase(packageName));
		model.put("moduleName", moduleName);
		model.put("subModuleName", StringUtils.isNotBlank(subModuleName)?"."+StringUtils.lowerCase(subModuleName):"");
		model.put("className", StringUtils.uncapitalize(className));
		model.put("ClassName", StringUtils.capitalize(className));
		model.put("classAuthor", StringUtils.isNotBlank(classAuthor)?classAuthor:"Generate Tools");
		model.put("classVersion", DateUtils.getDate());
		model.put("functionName", functionName);
		model.put("tableName", tableName);
		
		model.put("urlPrefix", "/"+model.get("className"));
		model.put("viewUrlPrefix", "/"+model.get("moduleName"));
		model.put("returnPrefix","modules"+ //StringUtils.substringAfterLast(model.get("packageName"),".")+"/"+
				model.get("viewUrlPrefix")+"/"+model.get("className"));
		model.put("viewPrefix",//StringUtils.substringAfterLast(model.get("packageName"),".")+"/"+
				model.get("urlPrefix"));
		
		model.put("permissionPrefix", model.get("className"));
		String[] strs = entityContent.split("##");
		model.put("columnContent",strs[0]);
		model.put("entityContent",strs[1]);
		
		System.out.println("-------------------------生成的相关文件------------------------");
		Template template = null;
		String content = null;
		String filePath =null;
		if(flag.indexOf("entity")!=-1||flag.length()==0){
			// 生成 Entity
			template = cfg.getTemplate("entity.ftl");
			content = FreeMarkers.renderTemplate(template, model);
			filePath = javaPath+separator+model.get("moduleName")+separator+"entity"
					+separator+StringUtils.lowerCase(subModuleName)+model.get("ClassName")+".java";
			writeFile(content, filePath);
			System.out.println("生成 Entity:"+filePath);
		}
		
		if(flag.indexOf("dao")!=-1||flag.length()==0){

			// 生成 Dao
			template = cfg.getTemplate("dao.ftl");
			content = FreeMarkers.renderTemplate(template, model);
			filePath = javaPath+separator+model.get("moduleName")+separator+"dao"+separator
					+StringUtils.lowerCase(subModuleName)+model.get("ClassName")+"Dao.java";
			writeFile(content, filePath);
			System.out.println("生成 Dao:"+filePath);

		}
		
		if(flag.indexOf("service")!=-1||flag.length()==0){

			// 生成 Service
			template = cfg.getTemplate("service.ftl");
			content = FreeMarkers.renderTemplate(template, model);
			filePath = javaPath+separator+model.get("moduleName")+separator+"service"+separator
					+StringUtils.lowerCase(subModuleName)+model.get("ClassName")+"Service.java";
			writeFile(content, filePath);
			System.out.println("生成 Service:"+filePath);

		}
		
		if(flag.indexOf("controler")!=-1||flag.length()==0){

			// 生成 Controller
			template = cfg.getTemplate("controller.ftl");
			content = FreeMarkers.renderTemplate(template, model);
			filePath = javaPath+separator+model.get("moduleName")+separator+"web"+separator
					+StringUtils.lowerCase(subModuleName)+model.get("ClassName")+"Controller.java";
			writeFile(content, filePath);
			System.out.println("生成 Controller:"+filePath);

		}
		
		if(flag.indexOf("form")!=-1||flag.length()==0){

			// 生成 ViewForm
			template = cfg.getTemplate("viewForm.ftl");
			content = FreeMarkers.renderTemplate(template, model);
			filePath = viewPath+separator+StringUtils.substringAfterLast(model.get("packageName"),".")
					+separator+model.get("moduleName")+separator+StringUtils.lowerCase(subModuleName)
					+model.get("className")+"Form.jsp";
			writeFile(content, filePath);
			System.out.println("生成 ViewForm:"+filePath);

		}
		
		if(flag.indexOf("list")!=-1||flag.length()==0){

			// 生成 ViewList
			template = cfg.getTemplate("viewList.ftl");
			content = FreeMarkers.renderTemplate(template, model);
			filePath = viewPath+separator+StringUtils.substringAfterLast(model.get("packageName"),".")
					+separator+model.get("moduleName")+separator+StringUtils.lowerCase(subModuleName)
					+model.get("className")+"List.jsp";
			writeFile(content, filePath);
			System.out.println("生成 ViewList:"+filePath);

		}
		
	}
	
	/**
	 * 将内容写入文件
	 * @param content
	 * @param filePath
	 */
	public static void writeFile(String content, String filePath) {
		try {
			if (FileUtils.createFile(filePath)){
				FileWriter fileWriter = new FileWriter(filePath, true);
				BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
				bufferedWriter.write(content);
				bufferedWriter.close();
				fileWriter.close();
			}else{
				//logger.info("生成失败，文件已存在！");
				System.out.println("生成失败，文件已存在！");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
