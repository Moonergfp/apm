package apm.modules.fileManage.service;

import java.io.File;
import java.util.List;
import java.util.Properties;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.ApmUtils;
import apm.modules.fileManage.dao.FileManagerDao;
import apm.modules.fileManage.entity.FileManager;
import apm.modules.sys.service.DictService;
/**
 * @author wq
 * @date 2013-8-30 上午10:30:21
 */
@Service
@Transactional(readOnly = true)
public class FileManagerService  extends BaseService<FileManagerDao, FileManager> {
	
	@Autowired
	private DictService dictService;
	
	//新建顶级目录
	@Transactional(readOnly = false)
	public  FileManager newFirstDir(){
		FileManager f = new FileManager();
		FileManager fileTemp = new FileManager();
		fileTemp.setId("0");
		f.setParent(fileTemp);
		f.setParentIds("0,");
		f.setName("顶级");
		f.setDelFlag("1");
		return dao.save(f);
	}
	
	//创建文件管理目录apm_file
	@Transactional(readOnly = false)
	public  FileManager newApmDir(FileManager f0){
	    //不存在文件目录管理目录时,新建
		//存在顶级目录的字典
		String keyValue ="";
		keyValue = ApmUtils.getDictValue("apm_file");
		if( keyValue == null){
       		return null;
       	}
		FileManager f1 = new FileManager();
		f1.setParent(f0);
		f1.setParentIds("0,"+f0.getId()+",");
		f1.setName(keyValue);  //根据类型即内部键名来获取路径
		f1.setPath(keyValue);
		return dao.save(f1);
	}
	
	//根据目录名创建目录,顶级目录,文件目录管理
	@Transactional(readOnly = false)
	public synchronized FileManager newDir(String dirName,String path, FileManager f0, FileManager f1){
		FileManager file = new FileManager();
		//上级目录为文件目录管理
		file.setParent(f1);
		file.setParentIds("0,"+f0.getId()+","+f1.getId()+",");
		file.setName(dirName);
		file.setPath(path);
		return dao.save(file);
	}
	//根据目录名创建目录,顶级目录,文件目录管理
	@Transactional(readOnly = false)
	public synchronized FileManager newDir1(String dirName,String path, FileManager f0, FileManager f1){
		FileManager file = new FileManager();
		//上级目录为文件目录管理
		file.setParent(f1);
//		file.setParentIds("0,"+f0.getId()+","+f1.getId()+",");
		file.setParentIds(f1.getParentIds()+f1.getId()+",");
		file.setName(dirName);
		file.setPath(path);
		return dao.save(file);
	}
	
	public List<FileManager> findAllList() {
		// TODO Auto-generated method stub
		return dao.findAllList();
	}

	public String findParentIdsById(String fileId) {
		// TODO Auto-generated method stub
		return dao.findParentIdsById(fileId);
	}
    //找到文件夹名
	public String findFileNameById(String id) {
		// TODO Auto-generated method stub
		return dao.findFileNameById(id);
	}
   //找到文件夹路径
	public String findPathById(String id){
		return dao.findPathById(id);
	}
	public FileManager findFirstFileId() {
		// TODO Auto-generated method stub
		return dao.findFirstFileId();
	}

	public FileManager findFileManagerByPIds(String pid) {
		// TODO Auto-generated method stub
		return dao.findFileManagerByPIds(pid);
	}

	public Page<FileManager> find(Page<FileManager> page,FileManager fileManager) {
		// TODO Auto-generated method stub
		DetachedCriteria dc = dao.createDetachedCriteria();
		dc.add(Restrictions.eq(FileManager.DEL_FLAG, FileManager.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return dao.find(page, dc);
	}

	//通过pids查找文件名
	public List<String> findNameByPids(String pids) {
		// TODO Auto-generated method stub
		return dao.findNameByPids(pids);
	}
	//通过pids查找文件名
	public String findNameByPids2(String pids) {
		// TODO Auto-generated method stub
		return dao.findNameByPids2(pids);
	}

	public List<FileManager> findAllFileManagers() {
		// TODO Auto-generated method stub
		return dao.findAllFileManagers();
	}

	//通过pids和目录名字找到文件目录信息
	public List<FileManager> findFileMaByPidsAndName(String firstpIds,String superiorMulu) {
		// TODO Auto-generated method stub
		return dao.findFileMaByPidsAndName(firstpIds,superiorMulu);
	}

	public FileManager findPath(String path) {
		// TODO Auto-generated method stub
		return dao.findPath(path);
	}

	@Transactional(readOnly = false)
	public void deleteAllManage() {
		// TODO Auto-generated method stub
		dao.deleteAllManage();
	}

	@Transactional(readOnly = false)
	public void saveEnitity(FileManager f){
		dao.clear();
		 dao.save(f);
	}

	public List<FileManager> findFileManagerByPId(String id) {
		// TODO Auto-generated method stub
		return dao.findFileManagerByPId(id);
	}

	public List<FileManager> findFileManagerByName(String fileName) {
		// TODO Auto-generated method stub
		return dao.findFileManagerByName(fileName);
	}

	public List<String> findAllIdsByPids(String id) {
		// TODO Auto-generated method stub
		return dao.findAllIdsByPids(id);
	}
}
