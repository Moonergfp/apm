package apm.modules.program.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import apm.common.core.Page;
import apm.common.mapper.JsonMapper;
import apm.common.utils.ApmUtils;
import apm.common.utils.FileUtils;
import apm.common.utils.StringUtils;
import apm.common.web.BaseController;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.fileManage.service.FileInfosaService;
import apm.modules.program.entity.Program;
import apm.modules.program.service.ProgramService;
import apm.modules.program.service.PublishProgramService;

import com.fasterxml.jackson.databind.JsonNode;

/**
 * 节目实体类Controller
 * @author gfp
 * @version 2015-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/program")
public class ProgramController extends BaseController<ProgramService, Program> {

	//注入其他的Service层或本层
	@Autowired
	private ProgramService programService;
	@Autowired
	private FileInfosaService fileInfosaService;
	@Autowired
	PublishProgramService publishProgramService;
	//节目制作初始化页面
	@RequestMapping(value="make")
	public String make(HttpServletRequest req){
		return "modules/program/programMake";
	}
	
	//返回到节目实体类列表页，完成分页显示
	@RequestMapping(value = {"list", ""})
	public String list(Program program, HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("----节目列表------");
		 Page<Program> page = service.find(new Page<Program>(request, response), program); 
        model.addAttribute("page", page);
        model.addAttribute("program", program);
		return "modules/program/programList";
	}
	
	//返回到节目实体类表单页
	@RequestMapping(value = "form")
	public String form(String ratio, String direction, HttpServletRequest req, Model model) {
		 String width = direction.equals("0")?ratio.split("[*]")[0]: ratio.split("[*]")[1];
		 String height = direction.equals("0")?ratio.split("[*]")[1]: ratio.split("[*]")[0];
		 model.addAttribute("width", width); //宽
		 model.addAttribute("height", height); //高
		 model.addAttribute("pName", req.getParameter("pName")); //节目名
		 model.addAttribute("advertiser", req.getParameter("advertiser")); //广告商
		 
		 System.out.println("width --"+ width + " -------height -------- "+height);
		 // Map map = new HashMap<String, Object>();
		 List<FileInfosa> fV = fileInfosaService.getFirstVedio(0, 6, "program_video_path");
		 //获取每个视频的缩略图
		 if(fV != null && fV.size() > 0){
			 for(FileInfosa f : fV){
				 //通过treeId获取缩略图文件
				 List<FileInfosa> fImg = fileInfosaService.findByTreeId(f.getId());
				 if(fImg != null && fImg.size() > 0){
					 f.setImgPath(fImg.get(0).getPath());
				 }
			 }
		 }
		 //map.put("vList", fV);
		//获取第一页视频文件,目前默认每一页为6个
		 model.addAttribute("vList", fV);
		 //获取背景图片
		 model.addAttribute("bList", fileInfosaService.getFirstVedio(0, 10, "back_img_path"));
		 //获取图片
		 model.addAttribute("iList", fileInfosaService.getFirstVedio(0, 10, "img_path"));
		 //获取ppt文件
		 List<FileInfosa> pList = fileInfosaService.getFirstVedio(0, 10, "ppt_path");
		 //获取每个ppt的所有图片
		 if(pList != null && pList.size() > 0){
			 for(FileInfosa f: pList){
				 if(f != null){
					 //ppt对应的图片id
					 f.setIds(fileInfosaService.findIdByTreeIdPpt(f.getId()));
					 //ppt对应的图片路径
					 f.setPptImgPath(fileInfosaService.findByTreeIdPpt(f.getId()));
				 }
			 }
		 }
		 model.addAttribute("pList", pList);
		 //获取word文档,设置html路径
		 List<FileInfosa> fW = fileInfosaService.getFirstVedio(0, 10, "word_path");
		 if(fW != null && fW.size() > 0){
			 for(FileInfosa f: fW){
				 List<FileInfosa> fH = fileInfosaService.findByTreeId(f.getId());
				 if(fH != null && fH.size() > 0){
					 f.setHtmlPath(fH.get(0).getPath());
				 }
			 }
		 }
		 model.addAttribute("wList", fW);
		//获取Excel文档,获取html路径
		 List<FileInfosa> fE = fileInfosaService.getFirstVedio(0, 10, "excel_path");
		 if(fE != null && fE.size() > 0){
			 for(FileInfosa f: fE){
				 List<FileInfosa> fH = fileInfosaService.findByTreeId(f.getId());
				 if(fH != null && fH.size() > 0){
					 f.setHtmlPath(fH.get(0).getPath());
				 }
			 }
		 }
		 model.addAttribute("eList", fE);
		 //获得音乐文件
		 model.addAttribute("mList", fileInfosaService.getFirstVedio(0, 10, "music_path"));
		return "modules/program/programForm";
	}
	
	//保存节目实体类信息，并返回到列表页
	@RequestMapping(value = "save")
	public String save(Program program, HttpServletRequest req, HttpServletResponse response, Model model) throws IOException {
		System.out.println(program);
		 //保存节目的基本信息
		 program = service.saveProgram(req, program);
		 //发送给终端的所有场景,同上
		 String [] terminalHtml = req.getParameterValues("terminalInput");
		 //所有元素的json字符串,存放每个元素的id
		 String eData = req.getParameter("terminalJH");
		 //System.out.println("terminalHtml ------" + terminalHtml);
		 //System.out.println("eData ------" + eData);
		 
		 //根据html字符串,生成一份完整的节目文件夹
		 if(terminalHtml != null && terminalHtml.length > 0){
			 //根据每个场景的html内容,生成html文件
			 //获取节目文件夹,应用服务器的物理路径
			 String dir = ApmUtils.filePath("program_list");
			 String path = dir + File.separator + program.getName();
			 for(int i = 0; i < terminalHtml.length; i++){
				 //场景路径, 规定用sceen + 当前场景索引号为文件夹名
				 int n = i+ 1; 
				 String sceenPath = path + File.separator + "scene" + n;
				 System.out.println(sceenPath);
				 File sceenFile = new File(sceenPath);
				 if(!sceenFile.exists()){
					 sceenFile.mkdirs();
				 }
				 //html文件路径
				 File hPath = new File(sceenPath + File.separator +"index.html");
				 FileWriter fw = new FileWriter(hPath);
				 //字符流写入文件中
				 BufferedWriter bw = new BufferedWriter(fw);
				 System.out.println(ApmUtils.terminalHtml(terminalHtml[i]));
				 bw.write(ApmUtils.terminalHtml(terminalHtml[i]));
				 bw.close();
				 fw.close();
			 }
			 
			 //拷贝相应的js和css文件至节目文件夹中
			 //js源文件路径
			 String jsPath = ApmUtils.getRootPath(" ", " ") + File.separator +"static" + File.separator + "program-file" + File.separator + "js";
			 System.out.println("jsPath ----- "+jsPath);
			 //复制整个js目录中的文件到节目中
			 FileUtils.copyDirectory(jsPath, path + File.separator + "js");
			 //css源文件路径
			 String cssPath = ApmUtils.getRootPath(" ", " ") + File.separator +"static" + File.separator + "program-file" + File.separator + "css"; 
			 System.out.println("cssPath ----- "+cssPath);
			 //复制整个css目录中的文件到节目中
			 FileUtils.copyDirectory(cssPath, path + File.separator + "css");
			 
			 //从文件服务器中下载所有元素至对应的节目文件夹中
			 //利用Jackson解析json字符串,获取相对应元素
			 JsonNode node = JsonMapper.getInstance().getMapper().readTree(eData);
			 System.out.println(node);
			 if(node != null){
				 //获取字符串ids
				 String ids = null;
				 //用来存放所有路径和ids
				 Map<String, Set<String>> map = new HashMap<String, Set<String>>();
				 //获取图片元素， 包括背景图片,图片,ppt图片
				 if(node.get("images") != null){
					 ids = node.get("images").asText();
					 map.put(path + File.separator + "imgaes", (Set<String>) StringUtils.getCollectionByString("set", ids, ","));
				 }
				 //视频
				 if(node.get("video") != null){
					  ids = node.get("video").asText();
					  map.put(path + File.separator + "video", (Set<String>) StringUtils.getCollectionByString("set", ids, ","));
				 }
				 //音乐
				 if(node.get("music") != null){
					 ids = node.get("music").asText();
					 map.put(path + File.separator + "music", (Set<String>) StringUtils.getCollectionByString("set", ids, ","));
				 }
				 //word,和excel放置html文件夹中 ,单独进行处理,有可能存在图片且为压缩文件
				 if(node.get("word") != null){
					 ids = node.get("word").asText();
					 //直接从应用服务器中获取,拷贝至对应的节目中
					 Set<String> wIds = (Set<String>) StringUtils.getCollectionByString("set", ids, ",");
					 if(wIds != null && wIds.size() > 0){
						 for(String wId : wIds){
							 //html和图片路径文件夹,判断是否存在,不存在时则直接从文件服务器中获取
							 //应用服务器word_html文件夹路径
							 String localPath = ApmUtils.filePath("word_path_html") + File.separator + wId;
							//用来判断是否在应用服务器中存在文件
							 boolean flag = copyWord(localPath, path, wId);
							 //应用服务器不存在文件时,从文件服务器中获取
							 if(!flag){
								 //下载到节目目录并解压,完成之后记得删除压缩文件
								 fileInfosaService.downloadZipOrTar(wId, path);
							 }
						 }
					 }
				 }
				 //excel
				 if(node.get("excel") != null){
					 ids = node.get("excel").asText();
					 map.put(path + File.separator + "html", (Set<String>) StringUtils.getCollectionByString("set", ids, ","));
				 }
				 //保存至相对应的文件夹中
				 if(map != null && map.size() > 0){
					 for(Entry<String, Set<String>> entry : map.entrySet()){
						 //路径
						 String key = entry.getKey();
						 Set<String> value = entry.getValue();
						 if(value != null && value.size() > 0){
							 for(String id : value){
								 //保存文件至节目相对应文件夹
								 fileInfosaService.download(id, key);
							 }
						 }
					 }
				 }
			 }
		 }
		 return "";
	}
	
	//拷贝word
	public boolean copyWord(String srcPath, String desPath, String id){
		 File wDir = new File(srcPath);
		 //目录存在时
		 if(wDir.exists() && wDir.isDirectory()){
			 //判断html文件是否存在
			 File hFile = new File( srcPath + File.separator + id + ".html");
			 if(hFile.exists() && hFile.isFile()){
				 //把该目录copy到节目中去
				 FileUtils.copyDirectory(srcPath, desPath + File.separator + "html");
				 return true;
			 } 
		 } 
		 return false;
	}
	
	@RequestMapping(value="preview")
	public String preview(HttpServletRequest req, HttpServletResponse response, Model model){
		//在谷歌下无法放入javascript, 有xss保护功能导致, 加入以下代码即可
		response.setHeader("X-XSS-Protection", "0");
		String dom = req.getParameter("dom");
		model.addAttribute("dom", dom);
		return "modules/program/programPreview";
	}

	//RSS验证
	/*@ResponseBody
	@RequestMapping(value="rssValid")
	public String rssValid(HttpServletRequest req) throws IllegalArgumentException, IOException, FeedException{
		String site = req.getParameter("site");
		System.out.println("site ------------ "+ site);
		//得到所有
		PraseXML px = new PraseXML(site);
		if(!px.isMessage()){
			return "非法路径";
		}
		return "true";
	}
	
	@RequestMapping(value="preview")
	public String preview(HttpServletRequest req, Model model){
		//得到所有
		String site = req.getParameter("rssSite");
		System.out.println("site ------------ "+ site);
		PraseXML px = new PraseXML(site);
		List<RSSItem> f = px.RSS_Praser();
		for(RSSItem r: f){
			System.out.println(r);
		}
		model.addAttribute("list", f);
		return "modules/program/rssPreview";
	}*/
}
