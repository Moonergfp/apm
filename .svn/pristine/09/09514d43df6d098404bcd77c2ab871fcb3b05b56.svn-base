package apm.modules.fileManage.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.SequenceInputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.apache.commons.fileupload.util.Streams;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import apm.common.config.Global;
import apm.common.mapper.JsonMapper;
import apm.common.utils.ApmUtils;
import apm.common.utils.FFMpegUtil;
import apm.common.utils.OfficeUtils;
import apm.common.utils.StringUtils;
import apm.common.utils.ZipUtils;
import apm.common.web.BaseController;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.fileManage.entity.FileManager;
import apm.modules.fileManage.service.FileInfosaService;
import apm.modules.fileManage.service.FileManagerService;
import apm.modules.sys.entity.User;
import apm.modules.sys.service.DictService;
import apm.modules.sys.support.Users;


/**
 * @author wq
 * @date 2013-8-30 上午10:30:21
 */
@Controller
@RequestMapping(value = "${adminPath}/fileInfosa")
public class FileInfosaController extends BaseController<FileInfosaService, FileInfosa>{
		
	@Autowired
	private FileManagerService fileManagerService;
	@Autowired
	private DictService dictService;
	//公共目录
	private final static String COMMON_DIR = "program_video_path,back_img_path,ppt_path,word_path,excel_path,music_path";
	@ResponseBody
	@RequestMapping(value="validDir")
	public String validDir(HttpServletRequest req){
		//上传之前判断是否已存在顶级目录,不存在则直接新建
		//首先到目录表中查找是否已经存在顶级目录。
		FileManager f0 = fileManagerService.findFirstFileId();
		//文件管理目录
		FileManager f1 = null;
		synchronized (this){
			if(f0 == null){
				 f0 = fileManagerService.newFirstDir();
			}
			f1 = fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
			 if(f1 == null){
				 f1 = fileManagerService.newApmDir(f0);
				 //新建之后如果还为null,则说明未配置文件管理目录
				 if(f1 == null){
					return "false, 未配置文件管理目录,如: apm_file";
				 }
			 }
		}
		return "ok";
	}
	
    /**
     * webuploader文件统一上传保存
     * 如果自定义请求controller，只需要调用uploaderGetId获取生成的文件ID即可
     * @param request
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "uploader")
	public  String uploader(MultipartHttpServletRequest request){
		//页面返回值,判断是否成功
		String fileId = "";
		//当前分页序号
		String chunk = request.getParameter("chunk"); 
		//分片总页数
		String chunksStr = request.getParameter("chunks");
		//保存文件的对应文件夹
		String folderName = request.getParameter("folderName");
		try {
			String  topDir = ApmUtils.getDictValue("apm_file");
			if(topDir == null){
				return "false, 未配置文件管理目录,如: apm_file";
			 }
			//获取文件在项目中的相对路径
			String apmConfig = ApmUtils.getRootPath(" ", " ") + File.separator + topDir;
			if(chunk != null && chunksStr != null){  //分片上传
				fileId = uploaderChunk(Integer.parseInt(chunk), Integer.parseInt(chunksStr), request, apmConfig, folderName);
			}else{			//不分片上传
				fileId = uploaderGetId(request, apmConfig, folderName);
			}
			FileInfosa f = service.get(fileId);
			//如果为视频,则需保存缩略图, 缩略图直接保存到根目录下, 但数据库中文件路径直接保存为文件服务器的路径
			//以视频的文件id作为图片的文件名,方便查找
			if("program_video_path".equals(folderName)){
				saveImage(request, fileId, topDir, folderName);
				//保存时长
				f.setNote(FFMpegUtil.getRuntime(f.getPath()) + "");
				service.save(f);
			}else if("ppt_path".equals(folderName)){//ppt上传之后生成图片
				savePptImage(request, fileId, topDir, folderName);
			}else if("word_path".equals(folderName)){//word文件上传之后生成html页面
				saveWordHtml(request, fileId, topDir, folderName);
			}else if("excel_path".equals(folderName)){//excel文件上传之后生成html页面
				saveExcelHtml(request, fileId, topDir, folderName);
			}else if("music_path".equals(folderName)){ //获取音乐时长
				f.setNote(FFMpegUtil.getRuntime(f.getPath()) + "");
				service.save(f);
			}
			//保存视频文件至文件服务器中
			if(f != null){
				fileId = toFileSystem(fileId, new File(f.getPath()));
			}
		} catch (Exception e) {
			fileId = "false,上传文件出错！";
		}
		return fileId;		
	}
	
	//保存excel生成的html文档
	public void saveExcelHtml(MultipartHttpServletRequest req, String fileId, String topDir, String folderName) throws IOException, TransformerException, ParserConfigurationException, InvalidFormatException{
		FileInfosa f = service.get(fileId);
		if(f != null){
			 String htmlDir = ApmUtils.getDictValue("excel_html_path");
			 String path = ApmUtils.getRootPath(" ", " ") + File.separator + topDir;
			 //拼接html生成的路径
			 path = htmlDir == null?path + File.separator + f.getId() + ".html": path + File.separator + htmlDir + File.separator + f.getId() + ".html";
			 //转化
			 OfficeUtils.convert2Html(f.getPath(), path, fileId);
			 File htmlF = new File(path);
			 if(htmlF.exists() && !htmlF.isDirectory()){
				//拼接下载路径
				//String downPath = (Global.getFileSystemPath() + "/" + topDir + path.split(topDir)[1]).replace("\\", "/");
				//保存至数据库中
				//String imgFileId = setToFileInfosa(htmlF, htmlF.getName(), downPath, fileId, htmlDir);
				//发送文件至文件服务器
				//toFileSystem(imgFileId, htmlF);
				//保存文件至文件服务器
				noSaveToFileSystem(htmlF);
			 }
		}
	}
	
	//保存word生成的html文档
	public void saveWordHtml(MultipartHttpServletRequest req, String fileId, String topDir, String folderName) throws IOException, TransformerException, ParserConfigurationException, InvalidFormatException{
		FileInfosa f = service.get(fileId);
		if(f != null){
		   String htmlDir = ApmUtils.getDictValue("word_html_path");
		    String path = ApmUtils.getRootPath(" ", " ") + File.separator + topDir;
			//拼接html生成的路径
			path = htmlDir == null?path + File.separator + f.getId() + File.separator + f.getId() + ".html": path + File.separator + htmlDir + File.separator + f.getId() +  File.separator + f.getId() + ".html";
			OfficeUtils.convert2Html(f.getPath(), path, f.getId());
			//判断html是否已生成
			File htmlF = new File(path);
			if(htmlF.exists() && !htmlF.isDirectory()){
				//拼接下载路径
				//String downPath =  ( Global.getFileSystemPath() + "/" + topDir + path.split(topDir)[1]).replace("\\", "/");
				//String imgFileId = setToFileInfosa(htmlF, htmlF.getName(), downPath, fileId, htmlDir);
				//把该word的所有图片全部传到文件服务器中,doc和docx的图片路径不同, docx 包含/work/media/图片 
				//把html页面和图片路径压缩到一个文件中发送到文件服务器
				//压缩目录
				String zipPath = htmlF.getParentFile().getPath();
				System.out.println("zip ----------- "+zipPath);
				//压缩输出路径
				String outPath = null;
				//判断当前操作系统
				if("win".equals(ApmUtils.getSystemTypex())){
					outPath = zipPath + ".zip";
					System.out.println("outPath --------- "+outPath);
					ZipUtils.zip(zipPath, outPath, "utf-8");
				}else{
					outPath = zipPath + ".tar";
					System.out.println("outPath --------- "+outPath);
					ZipUtils.tar(zipPath, outPath);
				}
				File zF = new File(outPath);
				if(zF.exists() && zF.isFile()){
					//上传至文件服务器
					noSaveToFileSystem(zF);
					//删除应用服务器生成的html文件以及图片目录
					deleteFile(new File(zipPath));
				}
				/*String imgPath = htmlF.getParentFile().getPath() + File.separator + f.getId();
				File imgF = new File(imgPath);
				//保存所有图片,区分doc和docx
				validDir(imgF);*/
				//发送文件至文件服务器
				/*toFileSystem(imgFileId, htmlF);*/
			}
		}
	}
	
	//递归删除目录机器下面的所有文件
	 public void deleteFile(File file){
		//为目录时
		if(file.exists() && file.isDirectory()){
			//得到下面的所有文件
			File[] fs = file.listFiles();
			for(File fImg: fs){
				//如果为文件,则说明为doc的图片
			      if(fImg.exists() && fImg.isFile()){
			    	  fImg.delete(); 
			      }else if(fImg.exists() && fImg.isDirectory()){//如果存在且为目录 ,则递归
			    	  deleteFile(fImg);
			      }
			}
		}
	} 
	
	//保存word产生的图片文档,图片路径存在差异
	/*public void validDir(File file){
		//为目录时
		if(file.exists() && file.isDirectory()){
			//得到下面的所有文件
			File[] fs = file.listFiles();
			for(File fImg: fs){
				//如果为文件,则说明为doc的图片
			      if(fImg.exists() && fImg.isFile()){
			    	  noSaveToFileSystem(fImg); //发送至文件服务器
			      }else if(fImg.exists() && fImg.isDirectory()){//如果存在且为目录 ,则递归
			    	  validDir(fImg);
			      }
			}
		}
	}*/
	
	//保存ppt的图片
	public void savePptImage(MultipartHttpServletRequest req, String fileId, String topDir, String folderName) throws IOException, TransformerException, ParserConfigurationException, InvalidFormatException{
		FileInfosa f = service.get(fileId);
		if(f != null){
			String imgDir = ApmUtils.getDictValue("ppt_img_path");
			String path = ApmUtils.getRootPath(" ", " ") + File.separator + topDir;
			//拼接图片生成的路径
			path = imgDir == null?path : path + File.separator + imgDir;
			//ppt或pptx转换成图片
			List<String> paths = OfficeUtils.convert2Html(f.getPath(), path, fileId);
			if(paths != null){
				//保存ppt的页面数
				f.setNote(paths.size() + "页");
				service.save(f);
				for(String str: paths){
					//判断图片是否存在
					File imgF = new File(str);
					if(imgF.exists()){
						//拼接文件下载路径
						String downPath = (req.getContextPath() + "/" + topDir + str.split(topDir)[1]).replace("\\", "/");
						String imgFileId = setToFileInfosa(imgF, imgF.getName(), downPath, fileId, imgDir);
						//发送文件至文件服务器
						toFileSystem(imgFileId, imgF);
					}
				}
			}
		}
	}
	
	//保存视频缩略图
	public void  saveImage(MultipartHttpServletRequest request, String srcFileId, String topDir, String folderName) throws IOException{
		FileInfosa f = service.get(srcFileId);
		if(f != null){
			//生成图片缩略图的绝对路径 jgp格式 
			String imgPath = ApmUtils.getRootPath(" ", " ") + File.separator + topDir + File.separator;
			//缩略图路径
			String vhPath = ApmUtils.getDictValue("video_thumbnail");
			//利用ffmpeg获取缩略图时,必须所有目录都已创建
			if(vhPath != null){
				File imgF = new File(imgPath + vhPath);
				if  (!imgF.exists()  && !imgF.isDirectory()){  
					imgF.mkdirs();
				}
			}
			//判断是否存在,存在则放在该目录下,不存在则直接放在根目录下
			imgPath = vhPath == null?imgPath + f.getId() + ".jpg": imgPath + vhPath + File.separator + f.getId() + ".jpg";
			if(FFMpegUtil.makeScreenCut(imgPath, "320x240", f.getPath())){
				//判断视频缩略图是否存在
				File imgFile = new File(imgPath);
				//拼接文件下载路径
				String downPath = (request.getContextPath() + "/" + topDir + imgPath.split(topDir)[1]).replace("\\", "/");
				//存在时保存至数据库中, 父目录即为视频文件id
			/*	//由于要生成缩略图,睡眠2秒钟 ,之后在判断图片是否已生成 暂时的处理方法
				  try {
			            Thread.sleep(2000);
			        } catch (InterruptedException e) {
			            e.printStackTrace(); 
			        }*/
				if(imgFile.exists()){
					String imgFileId = setToFileInfosa(imgFile, f.getId()+".jpg", downPath, f.getId(), vhPath);
					//保存文件至文件服务器
					toFileSystem(imgFileId, imgFile);
				}
			}else{
			  System.out.println("生成缩略图失败!");
			}
		}
	}
	
	//文件未保存至数据库直接保存到文件服务器
	public void noSaveToFileSystem(File file){
		if(file.exists()){
			//截取文件服务器的保存路径
			String  topDir = ApmUtils.getDictValue("apm_file");
			if(file.getPath().contains(topDir)){
				String realPath = topDir + file.getPath().split(topDir)[1];
				//去掉 '空格' 和  '#' '%'以及存在问题的特殊字符,用下划线代替
				realPath = realPath.replace(" ", "_").replace("#", "_").replace("%", "_").replace("`", "_").replace(",", "_").replace("，", "_").replace("&", "_").replace("\\", "/");
				String result = FileSystemUtil.uploadFile(Global.getFileSystemPath() + "/upload/" + realPath,file);
				if(!"success".equals(result)){
				 System.out.println("false, 文件未保存至文件服务器中");
				}
			}
		}
	}
	
	//一般文件保存后发送至文件服务器(已保存至数据库)
	public String toFileSystem(String fileId, File file){
		//文件保存至文件服务器
		FileInfosa f = service.get(fileId);
		//判断文件是否已上传成功
		if(f != null){
			//顶级目录
			FileManager f0 = fileManagerService.findFirstFileId();
			//文件管理目录
			FileManager f1 = fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
			//定制路径,规则为： 顶级目录/公司id/文件类型/文件名
			//截取顶级目录之后的路径
			if(f.getPath().contains(f1.getName())){
				//在文件服务上的最终路径
				String realPath = f1.getName() + f.getPath().split(f1.getName())[1];
				//去掉 '空格' 和  '#' '%'以及存在问题的特殊字符,用下划线代替
				realPath = realPath.replace(" ", "_").replace("#", "_").replace("%", "_").replace("`", "_").replace(",", "_").replace("，", "_").replace("&", "_").replace("\\", "/");
				String result = FileSystemUtil.uploadFile(Global.getFileSystemPath() + "/upload/" + realPath,file);
				if(!"success".equals(result)){
				   fileId = "false, 文件未保存至文件服务器中";
				}
			}
	     }
				return fileId;
	}
	
	/**
	 * 不分片上传文件
	 * @param request
	 * @param apmConfig
	 * @return
	 */
	
	public String uploaderGetId(MultipartHttpServletRequest request,
			String apmConfig, String folderName) {
		String uploadType = request.getParameter("uploadType");
		String fileId = null;
		//1.获取上传基路径	
		String basePath = getUploadBasePath(uploadType,folderName,apmConfig);
		//2.上传文件，返回文件
		fileId= uploadFile(request,basePath,folderName);
		return fileId;
	}
	
	/**
	 * 分片上传文件
	 * @param request
	 * @param apmConfig
	 * @return
	 */
	 public String uploaderChunk(int chunk,int chunkSize,MultipartHttpServletRequest request,String apmConfig, String folderName)throws InterruptedException, IOException{
		 String uploadType = request.getParameter("uploadType");
	     //1.获取上传基路径	
		 String basePath = getUploadBasePath(uploadType,folderName,apmConfig);
		 //2.分片上传到web服务器并最后合并返回文件ID
		 String fileId = uploadFileChunks(request,basePath,folderName,chunk,chunkSize);
		 return fileId;
	 }
	
	/**
	 * 根据上传类型获取上传的临时目的的绝对路径，根据不同需求只需要在该方法中根据对应的上传类型添加返回对应路径代码即可。
	 * @param uploadType  上传类型，如上传头像，上传屏幕截图等
	 * @param folderName
	 * @param apmConfig
	 * @return 上传临时目录
	 */
	public String getUploadBasePath(String uploadType,String folderName,String apmConfig){
		String basePath = null;
		 if(StringUtils.isEmpty(uploadType)){  //上传类型为空，则放到apm_file顶级目录中
			 basePath = apmConfig;
		 }else{
			 if("false".equals(uploadType)){//不需要终端目录
				 basePath = getNoTenDir(folderName,apmConfig);
			 }else{ //需要终端目录
				 basePath = getTenDir(folderName,apmConfig);
			 }
		 }
		 return basePath;
	}
	
	
	/**
	  * 文件分片上传到文件服务器，并判断分片合并，最后合并将文件信息写入文件表中
	  * @param request
	  * @param basePath
	  * @param folderName
	  * @param chunk
	  * @param chunkSize
	  * @return 文件ID
	  * @throws IOException
	  */
	 public String uploadFileChunks(MultipartHttpServletRequest request,String basePath,String folderName,int chunk,int chunkSize) throws IOException{
		//用于区分临时文件的唯一性
		String sessionId = request.getSession().getId();
		String fileId = null;
		//建立用于存储分片文件的临时文件夹
		File partFile = null;//分片文件
		String fileName = null;//文件名
		FileOutputStream fileOutputStream = null;//输出流，用于将文件流写到硬盘
		StringBuffer suffix = new StringBuffer().append(".").append( sessionId).append(chunk).append(".").append(folderName).append(".part");//分片文件，的前缀
		StringBuffer path = new StringBuffer(basePath);
		List<MultipartFile> files = request.getFiles("file");
		if(files.isEmpty()){
			return("false,文件上传失败,您未选择文件!");
		}else{
			fileName = files.get(0).getOriginalFilename();
			//用来判断是否已存在
			File vFile = new File(path.toString()+File.separator+fileName);
			if(vFile.exists() || fileExist(vFile)){
				return "false,文件重名，不能上传";
			}
			partFile = new File(path.toString()+File.separator+suffix);//将分片文件写入磁盘
			if(!partFile.exists()){
				partFile.createNewFile();
			}
			try {
				fileOutputStream = new FileOutputStream(partFile);
				fileOutputStream.write(files.get(0).getBytes());
				fileOutputStream.flush();
			} catch (Exception e) {
				if(partFile.exists()){
					fileOutputStream.close();  
					partFile.delete();
				}
				e.printStackTrace();  
			}finally{
				// 关闭流  
				fileOutputStream.close();  
			}
			
			//用于标识是否进行合并文件
			boolean combineFalg = getCombineFlag(true,vFile.getPath(),chunkSize);
			if(combineFalg){
				fileId = combine(request, sessionId, chunkSize, path.toString(), fileName, path.toString(), folderName, folderName);
				//删除文件
				for(int i=0;i<chunkSize;i++){
					new File(path.toString()+File.separator+"."+sessionId+i+"."+folderName+".part").getAbsoluteFile().delete();
				}
				//删除内存中的缓存
				delFileMapInfo(vFile.getPath());
			}else{
				//fileId = "false,第"+chunk+"片文件！";
				fileId = null;//返回false 会被当作上传分片失败，实际上这里只是判断分片未全部上传完,不该合并分片
			}
		}
		return fileId;
		
	 }
	 
	 
	/**
	 * 不是分片上传，上传文件到web服务器中，并且将文件信息插入文件信息表中
	 * @param request 上传的request
	 * @paam basePath 上传基路径 
	 * @return 文件ID
	 */
	public String uploadFile(MultipartHttpServletRequest request,String basePath,String folderName){
		List<MultipartFile> files = request.getFiles("file"); 
  		if(files.get(0).isEmpty()){
  			return("false,文件上传失败,您未选择文件!");
  		}else{
  			StringBuffer path = new StringBuffer(basePath);
  			String fileName = null;
  			String fileId = null;
  			 FileOutputStream fileOutputStream = null;  
  			  for (int i = 0; i < files.size(); i++) {
  				if (!(files.get(i).isEmpty())) {
  					path = path.append(File.separator ).append(files.get(i).getOriginalFilename());
  					fileName = files.get(i).getOriginalFilename();
  				    File file = new File(path.toString()); // 新建一个文件  
  				    //判断是否存在相同的的文件==数据库或硬盘存在===
  					if(file.exists() || fileExist(file)){
  						return "false,文件重名，不能上传";
  					}
  					try {  
				    		fileOutputStream = new FileOutputStream(file);  
				    		fileOutputStream.write(files.get(i).getBytes());  
				    		fileOutputStream.flush();  
				    		//保存到文件信息中
					    	fileId = setToFileInfosa(file,fileName,path.toString(),null,folderName);
				    	} catch (Exception e) {
				    		e.printStackTrace(); 
				    		return("false,文件上传失败!");
				    	}finally{
				    		if (fileOutputStream != null) { // 关闭流  
				    			try {  
				    				fileOutputStream.close();  
				    			} catch (Exception e) { 
				    				e.printStackTrace();  
				    			}  
				    		}  
				    	 } 
  				   }
  			    }
  			 return fileId;
  		}
	}
	
	
	/**
	 * 合并文件
	 * @param sessionId
	 * @param size
	 * @param objectFilePath
	 * @param fileName
	 * @param chunkFolder
	 * @param subFolder
	 * @param folderName
	 * @return
	 * @throws IOException
	 */
	public  String combine(MultipartHttpServletRequest req, String sessionId,int size,String objectFilePath,String fileName,String chunkFolder, String subFolder,String folderName)throws IOException {
		String fileId = "";
		//放到 文件信息表中 ,首先获得目录id 
		String partPath = objectFilePath+File.separator+".";
		ArrayList<FileInputStream> al = new ArrayList<FileInputStream>();
		for(int i = 0;i<size;i++) {
			al.add(new FileInputStream(partPath+sessionId+i+"."+folderName+".part"));
		}
		final Iterator<FileInputStream> it = al.iterator();
		Enumeration<FileInputStream> en = new Enumeration<FileInputStream>() {
			public boolean hasMoreElements() {
				return it.hasNext();//从内部类中访问局部变量 it；需要被声明为最终类型
			}
			public FileInputStream nextElement() {
				return it.next();
			}
		};
		SequenceInputStream sq = new SequenceInputStream(en);
		FileOutputStream fout = new FileOutputStream(objectFilePath+File.separator+fileName);
		byte[] by = new byte[1024*1024];
		int len = 0;
		while((len= sq.read(by))!=-1) {
			fout.write(by,0,len);
			fout.flush();
		}
		File file = new File(objectFilePath+File.separator+fileName);
		//保存到文件信息中
	  	fileId = setToFileInfosa(file,fileName,file.getPath(),null,subFolder);
		fout.close();
		sq.close();
		return fileId;
	}
	
	/**
	 * 删除分片文件信息缓存
	 * @param path
	 */
	public  void delFileMapInfo(String path){
		//设置缓存，标识该分片上传完成
		FileModuleUploadMap.getInstance().delfileModuleUpload(path);
	}
	
	
	/**
	 * 获取上传的绝对路径  apm_file/cId/folderName
	 * @param 文件根目录
	 * @return 返回目录绝对路径
	 */
	public String getNoTenDir(String folderName,String apmConfig){
	 	//步骤1.获取路径 2.判断路径存在否，存在返回，不存在创建  3.获取最终path/name的目录id
	 	StringBuffer path =  new StringBuffer(apmConfig);
       	String cId = Users.currentUser().getCompany().getId();
       	if(!COMMON_DIR.contains(folderName)){
       		path = path.append(File.separator).append(cId);
       	}
     	String subFolder=null;
    	if(StringUtils.isNotBlank(folderName)){
       		 subFolder = ApmUtils.getDictValue(folderName);
       		//不存在时直接用标签名
       		if(subFolder == null){
       			subFolder = folderName;
           	}
		}
    	path.append(File.separator).append(subFolder);
    	 //创建文件
      	File filex = new File(path.toString());
   		if(!filex.exists()){
   			filex.mkdirs();
   		}
		return path.toString();
	}
	
	/**
	 * 需要终端目录
	 * @param folderName
	 * @param apmConfig
	 * @return
	 */
	public String getTenDir(String folderName, String apmConfig) {
		StringBuffer path =  new StringBuffer(apmConfig);
       	String cId = Users.currentUser().getCompany().getId();
       	path = path.append(File.separator).append(cId);
     	String subFolder=null;
    	if(StringUtils.isNotBlank(folderName)){
       		 subFolder = ApmUtils.getDictValue(folderName);
       		//不存在时直接用标签名
       		if(subFolder == null){
       			subFolder = folderName;
           	}
		}
    	path.append(File.separator).append(subFolder);
    	String terminalId = "47970fba4f61e5c0a8822";
    	path.append(File.separator).append(terminalId);
    	 //创建文件
      	File filex = new File(path.toString());
   		if(!filex.exists()){
   			filex.mkdirs();
   		}
		return path.toString();
	}


	/**
	 * 判断是分片文件是否上传完整
	 * @param combineFalg
	 * @param path
	 * @param chunks
	 * @return
	 */
	public static boolean getCombineFlag(boolean combineFalg,String path,int chunks){
		//设置缓存，标识该分片上传完成
		FileModuleUploadMap fmum = FileModuleUploadMap.getInstance();
		fmum.setfileModuleUpload(path);
		//如果上传完成的分片文件不齐全，则标识不进行合并文件
		System.out.println("当前数目 -----------" + fmum.getfileModuleUpload(path));
		System.out.println("总数 --------------" + chunks);
		if(fmum.getfileModuleUpload(path) != chunks){
			combineFalg = false;
		}
		return combineFalg;
	}

	/**
	 * 将文件信息放入到文件管理中，同时要再根目录下，用于存储
	 * @param file
	 * @param fileName
	 * @param path
	 * @return
	 */
	public String setToFileInfosa(File file, String fileName, String path,String fileCatalogId,String type) {
		FileInfosa fileInfosa = new FileInfosa();
		    User uploader = Users.currentUser();
			long fileSize = file.length();
			String fileSize2 = String .valueOf(fileSize);
			Double fileSize3 = Double.parseDouble(fileSize2);
			if(fileSize<1048576){
				fileInfosa.setSize(new DecimalFormat("#.##").format(fileSize3/1024)+"KB");
			}if(1048576<=fileSize&&fileSize<1073741824){
				fileInfosa.setSize(new DecimalFormat("#.##").format(fileSize3/1048576)+"M");
			}if(1073741824<=fileSize){
				fileInfosa.setSize(new DecimalFormat("#.##").format(fileSize3/1073741824)+"G");
			}	
		     fileInfosa.setName(fileName);
		     path = path.replace("\\", File.separator).replace("/", File.separator);
		     fileInfosa.setPath(path);
		     fileInfosa.setType(type);
		     fileInfosa.setDate(new Date());
		     fileInfosa.setUploader(uploader.getId());
		     fileInfosa.setVersion("1");
		     fileInfosa.setTreeId(fileCatalogId);
		     fileInfosa.setTenandId(uploader.getCompany().getId()); //公司id
		     //保存html文件在应用服务器上的路径
		     //fileInfosa.setRemarks(file.getPath());
		     service.save(fileInfosa);
		     return fileInfosa.getId();
	}
	
	//判断上传的文件是否存在,false代表不存在反正存在
	private  boolean fileExist(File file) {
			//并且数据库中也存在此记录
			FileInfosa fileInfosa = service.findByPathO(file.getAbsolutePath());
			if(fileInfosa != null){
				return true;
			}
		return false;
	}
	
	 //上传之后重新获取文件的相关信息
	 @ResponseBody
	 @RequestMapping(value="getFile")
	 public String getFile(HttpServletRequest req){
		 String fileId = req.getParameter("fileId");
		 FileInfosa f = service.get(fileId);
		 Map<String, Object> map = new HashMap<String, Object>();
		 if(f != null){
			 //修改文件的下载路径,更改为文件服务器的路径 
			 if("back_img_path".equals(f.getType()) || "img_path".equals(f.getType()) || "music_path".equals(f.getType()) || "program_video_path".equals(f.getType())){
				 String topDir = ApmUtils.getDictValue("apm_file");
				 String realPath = (req.getContextPath() + "/" + topDir + f.getPath().split(topDir)[1]).replace("\\", "/");
				 f.setPath(realPath);
				 service.save(f);
			 }
			 //视频文件
			 if("program_video_path".equals(f.getType())){
				 //根据视频id文件找寻缩略图文件
				 List<FileInfosa> fImg = service.findByTreeId(fileId);
				 //缩略图的下载路径
				 map.put("imgPath", fImg.get(0).getPath());
			 }
			 map.put("file", f);
			 map.put("flag", f.getType());
		 }
		 return JsonMapper.getInstance().toJson(map);
	 }
	 
	 //从文件服务器上下载相关文件,主要用来；获取word和excel文件的html文件,解决节目跨域访问问题
	 //word由于存在图片,进行打包之后压缩,同时记得删除压缩文件
	 @ResponseBody
	 @RequestMapping(value="download")
	 public String download(String id, HttpServletRequest req) throws Exception{
		 //html文件
		 //文件服务器上的路径
		 String fileSys = null;
		 //应用服务器上的路径
		 String realFile = null;
		 FileInfosa f = service.get(id);
		 if("word_path".equals(f.getType())){
			  fileSys = ApmUtils.fileSystemPath("word_html_path") + "/" + f.getId();
			  realFile = ApmUtils.filePath("word_html_path") + File.separator + f.getId() + File.separator + f.getId();
		 }else if("excel_path".equals(f.getType())){
			 fileSys = ApmUtils.fileSystemPath("excel_html_path") + "/" + f.getId() + ".html";
			 realFile = ApmUtils.filePath("excel_html_path") + File.separator + f.getId() +".html";
		 }
		 //判断系统
		 if("word_path".equals(f.getType())){
			 if("win".equals(ApmUtils.getSystemTypex())){
				 fileSys += ".zip";
				 realFile += ".zip";
			 }else{
				 fileSys += ".tar";
				 realFile += ".tar";
			 }
		 }
		 
		 //1.获取指定地址的输入流.
		 URL url = new URL(fileSys);
		 InputStream in = url.openStream();
		 System.out.println("realFile ------------- " + realFile);
		 
		 //2.在指定文件夹下创建文件。
		 File fZ = new File(realFile);
		 if(!fZ.exists()){
			 File pF = new File(fZ.getParentFile().getPath());
			 pF.mkdirs();
			 fZ.createNewFile();
		 }
		 
		 //3.将下载保存到文件。
		 FileOutputStream out = new FileOutputStream(fZ);
		 Streams.copy(in, out, true);
		 
		 //解压文件
 	   if("word_path".equals(f.getType())){
			 if("win".equals(ApmUtils.getSystemTypex())){
				 ZipUtils.unzipFile(fZ.getPath());
			 }else{
				 //还未作,打算现在windows上跑通之后在做
				 ZipUtils.untar("", "");
			 }
		 }else{
			 //excel不存在图片 ,改成相对路径
			 return ApmUtils.comPath("excel_html_path", req) + "/" + f.getId() +".html";
		 } 
		 //删除压缩文件
		 fZ.delete();
		 //获取得到的html路径
		 System.out.println(ApmUtils.comPath("word_html_path", req) + "/" + f.getId() + "/" + f.getId() + ".html");
		 return ApmUtils.comPath("word_html_path", req) + "/" + f.getId() + "/" + f.getId() + ".html";
	 }
}