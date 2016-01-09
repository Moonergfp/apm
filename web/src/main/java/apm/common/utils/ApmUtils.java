package apm.common.utils;

import java.io.File;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import apm.common.config.Global;
import apm.modules.fileManage.entity.FileManager;
import apm.modules.fileManage.web.FileInfosaController;
import apm.modules.sys.entity.Dict;
import apm.modules.terminal.entity.MsgModel;

/**
 * 项目管理工具类
 * @author wq
 * @version 2014-6-11
 */
public class ApmUtils extends ApmInstance{
	
	private static Logger log=LoggerFactory.getLogger(ApmUtils.class);
    public static String SUCCESS = "SUCCESS"; //上传用户头像类型
    
	/**
	 * 根据类型即内部键名判断是否存在键值
	 * @param type
	 * @param label
	 */
	public static String getDictValue(String type){
		String keyValue = null;
		try{
			Dict dict = dictService.findByTypeAndLab(type);
			//当不存在时
			if(dict == null){
				return null;
			}
			//获取配置值
			keyValue = dict.getLabel();
			if(StringUtils.isBlank(keyValue)){
				//获取默认键值
				keyValue = dict.getValue();
			}
		}catch(NullPointerException e){
			log.error(e.getMessage(), e);
			e.getMessage();
			keyValue = null;
		}
		 return keyValue;
	}
	
	/**
	* 输入：无
	* 输出：返回系统类别，windows系列的系统返回win,其他系列的返回linux
	*  
	*/	
	public static String getSystemTypex() {
		Properties prop = System.getProperties();
		String systemType = "not";
		String os = prop.getProperty("os.name");
		// System.out.println("操作系统是"+os);
		System.out.println("os is" + os);
		if (os.startsWith("win") || os.startsWith("Win")) {
			// System.out.println("操作系统"+os+"属于windows系列");
			System.out.println("os:" + os + "is windows type");
			systemType = "win";
		} else {
			// System.out.println("操作系统"+os+"不属于windows系列");
			System.out.println("os:" + os + " not windows type");
			systemType = "linux";
		}
		return systemType;
	}
	/**
	 * 
	 * getDictValue:得到多个值，上述方法只能得到唯一的单个值 <br/> 
	 * 
	 * @author whc 
	 * @param type
	 * @return 
	 * @since JDK 1.8
	 */
	public static List<Dict> getDictValues(String type){
		return dictService.findAllByTypeAndLab(type);
	}
	
	
	/**
	 * 获取项目路径
	 * @param windowsBlank
	 * @param linuxBlank
	 * @return
	 */
	public static String getRootPath(String windowsBlank,String linuxBlank) {
		  String classPath = ApmUtils.class.getClassLoader().getResource("/").getPath();
		  System.out.println(classPath);
		  String rootPath  = "";
		  //windows下
		  if("\\".equals(File.separator)){   
		   rootPath  = classPath.substring(1,classPath.indexOf("/WEB-INF/classes"));
		   rootPath = rootPath.replace("/", "\\").replace("%20",windowsBlank);
		  }
		  //linux下
		  if("/".equals(File.separator)){   
		   rootPath  = classPath.substring(0,classPath.indexOf("/WEB-INF/classes"));
		   rootPath = rootPath.replace("\\", "/").replace("%20",linuxBlank);
		  }
		  return rootPath;
	 }
	
	/**
	 * 请求netty服务器,使用HttpClient
	 * @param outputStr
	 * @return MsgModel数据模型
	 * @throws Exception 
	 */
	public static MsgModel httpNeetyRequest(String outputStr) throws Exception{
		try{
			HttpClient httpClient = new DefaultHttpClient();
			HttpPost post = new HttpPost(Global.getConfig("nettyIp"));
			StringEntity entity = new StringEntity(outputStr,"utf-8");//解决中文乱码问题 
			entity.setContentType("application/json");
			post.setEntity(entity);
			HttpResponse result = httpClient.execute(post);
			String resData = EntityUtils.toString(result.getEntity());   //请求返回数据
			return JSONUtils.json2pojo(resData, MsgModel.class);
		}catch(Exception e){
			throw new Exception("请求netty错误");
		}
	}
	
	/**
	 * 生成文件下载路径
	 * @return
	 */
	public static String downLoadPath(String path){
		//获取文件顶级目录
		FileManager f0 = ApmUtils.fileManagerService.findFirstFileId();
		FileManager f1 = ApmUtils.fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
		String prePath = f1.getName() + path.split(f1.getName())[1];
		return "/apm-web/"+prePath;
	}
	
	//获取文件服务器的路径
	public static String fileSystemPath(String type){
		FileManager f0 = ApmUtils.fileManagerService.findFirstFileId();
		FileManager f1 = ApmUtils.fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
		//获取字典中相对应的值
		type = getDictValue(type);
		if(type != null){
			return  Global.getFileSystemPath() +"/" +f1.getPath() + "/" + type;
		}
		return  Global.getFileSystemPath() +"/" +f1.getPath();
	}
	
	//获取应用服务器的物理路径
	public static String filePath(String type){
		FileManager f0 = ApmUtils.fileManagerService.findFirstFileId();
		FileManager f1 = ApmUtils.fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
		//获取字典中相对应的值
		type = getDictValue(type);
		if(type != null){
			return  getRootPath(" ", " ") + File.separator + f1.getPath() + File.separator + type;
		}
		return getRootPath(" ", " ") + File.separator + f1.getPath();
	}
	
	//获取应用服务器的相对路径
	public static String comPath(String type, HttpServletRequest req){
		FileManager f0 = ApmUtils.fileManagerService.findFirstFileId();
		FileManager f1 = ApmUtils.fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
		//获取字典中相对应的值
		type = getDictValue(type);
		if(type != null){
			return  req.getContextPath() + "/" + f1.getPath() + "/" + type;
		}
		return  req.getContextPath() + "/" + f1.getPath();
	}
	
	/**
	 * 根据特定的html内容生成html页面
	 * @param content
	 * @return
	 */
	public static String terminalHtml(String content){
		StringBuilder sb = new StringBuilder();
		sb.setLength(0);
		sb.append("<html><head><title>节目播放</title>" +
				"<meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>" +
				"<meta http-equiv='Cache-Control' content='no-store'/>" +
				"<meta http-equiv='Pragma' content='no-cache'/>" +
				"<meta http-equiv='Expires' content='0'/>" +
				"<meta http-equiv='X-UA-Compatible' content='IE=7,IE=9,IE=10'/>" +
				"<script src='../js/jquery-1.9.1.min.js' type='text/javascript'></script>" +
				"<link href='../css/bootstrap.min.css' type='text/css' rel='stylesheet'>" +
				"<link href='../css/font-awesome.min.css' type='text/css' rel='stylesheet'>" +
				"<script src='../js/bootstrap.min.js' type='text/javascript'></script>" +
				"<link rel='stylesheet' type='text/css' href='../css/preview.css'>" +
				"<link rel='stylesheet' type='text/css' href='../css/initaudioplayer-1.css'>" +
				"<script src='../js/flowplayer-3.2.13.min.js' type='text/javascript'></script>" +
				"<script src='../js/getTime.js'></script>" +	
				"<script src='../js/getTimeAdd.js'></script>" +
				"<script type='text/javascript' src='../js/kxbdSuperMarquee.js'></script>" +
				"<script src='../js/jquery.marquee.min.js'></script></head><body>");
		sb.append(content + "</body></html>");
		return sb.toString();
	}
}