package apm.modules.fileManage.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.fileupload.util.Streams;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.common.service.BaseService;
import apm.common.utils.ApmUtils;
import apm.common.utils.ZipUtils;
import apm.modules.fileManage.dao.FileInfosaDao;
import apm.modules.fileManage.entity.FileInfosa;
/**
 * @author wq
 * @date 2013-8-30 上午10:30:21
 */
@Service
@Transactional(readOnly = true)
public class FileInfosaService  extends BaseService<FileInfosaDao, FileInfosa> {
	
	//通过文件路径查找文件实体信息
	public  FileInfosa  findByPathO(String filePath) {
		// TODO Auto-generated method stub
		return dao.findByPathO(filePath);
	}

	/**
	 * 查找终端屏幕最新截图
	 * @param dicValue
	 * @param terminalId
	 * @return
	 */
	public List<FileInfosa> findScreenShoot(String dicValue, String terminalId,Date date) {
		return dao.findScreenShoot(dicValue,terminalId,date);
	}
	

	/**
	 * 查找终端屏幕所有截图
	 * @param dicValue
	 * @param terminalId
	 * @return
	 */
	public List<FileInfosa> findScreenShoot(String dicValue, String terminalId) {
		return dao.findScreenShoot(dicValue,terminalId);
	}
	
	//通过treeId找到视频对应的缩略图
	public List<FileInfosa> findByTreeId(String treeId){
		return dao.findByTreeId(treeId);
	}
	
	//通过treeId找到ppt对应的所有图片路径
	public List<String> findByTreeIdPpt(String treeId){
		return dao.findByTreeIdPpt(treeId);
	}
	
	//通过treeId找到ppt所对应的id
	public List<String> findIdByTreeIdPpt(String treeId){
		return dao.findIdByTreeIdPpt(treeId);
	}
	
	//寻找第一页视频文件,默认六条
	public List<FileInfosa> getFirstVedio(int start, int size, String type){
		return dao.getFirstVedio(start, size, type);
	}

	/** 
	 * getTerminalNewestVersion:得到系统公共升级包 的最新版本 <br/> 
	 * @author whc 
	 * @param type
	 * @param string
	 * @return 
	 * @since JDK 1.8 
	 */  
	public FileInfosa getTerminalNewestPackage(String type) {
		return dao.getTerminalNewestSysVersion(type);
	}
	
	 //根据数据库中的相关信息,下载服务器上的文件
	 public boolean download(String fileId, String desPath) throws IOException{
		 FileInfosa f = dao.findOne(fileId);
		 if(f != null){
			 //下载路径
			 String dPath = ApmUtils.fileSystemPath(f.getType()) + "/" + f.getName();
			 return  downloadFile(dPath, desPath);
		 }
		 return false;
	 }
	 
	 //下载文件
	 public boolean downloadFile(String srcPath, String desPath) throws IOException{
		 System.out.println("srcPath ----- "+srcPath);
		 System.out.println("desPath ----- "+desPath);
		 File f = new File(desPath);
		 //创建父目录
		 if(!f.getParentFile().exists()){
			 new File(f.getParent()).mkdirs();
		 }
		 //是否存在文件
		 if(!f.exists()){
			 f.createNewFile();
		 }
		 //获取该文件流
		 URL url = new URL(srcPath);
		 InputStream in = url.openStream();
		 
		 //将下载保存到文件。
		 FileOutputStream out = new FileOutputStream(f);
		 Streams.copy(in, out, true);
		 return true;
	 }
	 
	 
	 /**
	  *  从文件服务器中下载压缩文件并解压,主要针对于word文档
	  * @param fileId  文件id
	  * @param path 节目路径
	  * @return
	  */
	 public boolean downloadZipOrTar(String fileId, String path){
		 //文件服务器路径
		String fileSys = getPathById(fileId, path).split(",")[0];
		//应用服务器路径
		String realFile = getPathById(fileId, path).split(",")[1];
		 File fZ = new File(fileSys);
		 try {
			 //下载
			downloadFile(fileSys, realFile);
			//解压
			if("win".equals(ApmUtils.getSystemTypex())){
				 ZipUtils.unzipFile(fZ.getPath());
			 }else{
				 //还未作,打算现在windows上跑通之后在做
				 ZipUtils.untar("", "");
			 }
			//删除压缩文件
			 fZ.delete();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		 return true;
	 }
	 
	 /**
	  * 根据文件id, 获取文件在节目中的路径 , 主要针对于word文档 ,通过判断可扩展
	  * @param id 文件id
	  * @param path 节目路径
	  * @return
	  */
	 public String getPathById(String id, String path){
		 FileInfosa f = dao.findOne(id);
		 if(f != null){
			    //文件服务器路径
				String fileSys = ApmUtils.fileSystemPath("word_html_path") + "/" + f.getId();
				//应用服务器节目路径
				String realFile = path + File.separator + "html" + File.separator + f.getId();
			/*	String realFile = ApmUtils.filePath("word_html_path") + File.separator + fileId + File.separator + fileId;*/
				//根据系统判断
				 if("win".equals(ApmUtils.getSystemTypex())){
					 fileSys += ".zip";
					 realFile += ".zip";
				 }else{
					 fileSys += ".tar";
					 realFile += ".tar";
				 }
				 return fileSys + "," + realFile;
		 }
		 return null;
	 }
}
