package apm.modules.fileManage.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;
import apm.modules.fileManage.entity.FileManager;

/**
 * @author wq
 * @date 2013-8-30 上午10:29:46
 */
public interface FileManagerDao extends FileManagerDaoCustom, JpaDao<FileManager> {
	@Query("from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "' order by sort")
	public List<FileManager> findAllList();

	//根据id查找所有父id
	@Query("select parentIds from FileManager where delFlag='" 
			+ FileManager.DEL_FLAG_NORMAL + "'and id = ?1")
	public String findParentIdsById(String fileId);
    //根据id查找文件名字
	@Query("select name from FileManager where delFlag='" 
			+ FileManager.DEL_FLAG_NORMAL + "'and id = ?1")
	public String findFileNameById(String id);
	//根据id查找文件夹目录
	@Query("select path from FileManager where delFlag = '"+FileManager.DEL_FLAG_NORMAL+"' and id = ?1")
	public String findPathById(String id);
	//查询顶级目录
	@Query("from FileManager where delFlag='" 
			+ FileManager.DEL_FLAG_NORMAL + "'and parentIds = '0,'")
	public FileManager findFirstFileId();
	
	@Query("from FileManager where delFlag='" 
			+ FileManager.DEL_FLAG_NORMAL + "'and parentIds = ?1")
	public FileManager findFileManagerByPIds(String pid);

	//通过pids查找文件名
	@Query("select name from FileManager where delFlag='"+ FileManager.DEL_FLAG_NORMAL + "'and parentIds = ?1")
	public List<String> findNameByPids(String pids);
	
	//通过pids查找文件名
	@Query("select name from FileManager where delFlag='"+ FileManager.DEL_FLAG_NORMAL + "'and parentIds = ?1")
	public String findNameByPids2(String pids);

	@Query("from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "'")
	public List<FileManager> findAllFileManagers();

	//通过pids和目录名字找到目录实体信息
	@Query("from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "'and parentIds = ?1 and name = ?2 order by updateDate desc")
	public List<FileManager> findFileMaByPidsAndName(String firstpIds,String superiorMulu);

	@Query("from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "'and path = ?1")
	public FileManager findPath(String path);

	@Modifying
	@Query("delete from FileManager")
	public void deleteAllManage();

	@Query("from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "'and parent.id = ?1")
	public List<FileManager> findFileManagerByPId(String id);

	@Query("from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "'and name like ?1")
	public List<FileManager> findFileManagerByName(String fileName);

	@Query("select id from FileManager where delFlag='" + FileManager.DEL_FLAG_NORMAL + "'and parentIds like ?1")
	public List<String> findAllIdsByPids(String id);
}

/**
 * DAO自定义接口
 */
interface FileManagerDaoCustom extends Dao<FileManager> {

}

/**
 * DAO自定义接口实现
 */
@Repository
class FileManagerDaoImpl extends DaoImpl<FileManager> implements FileManagerDaoCustom {

}
